# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::SessionsController, type: :controller do
  let!(:admin) do
    create(
      :administrator,
      name: 'Admin',
      phone: '+79095673421',
      password: 'secure'
    )
  end

  describe 'GET#new' do
    subject { get :new }

    context 'when unauthenticated' do
      it 'renders auth page' do
        expect(subject).to render_template(:new)
        expect_status(200)
      end
    end

    context 'when authenticated' do
      as_admin :admin

      it 'redirects to admin_root_path' do
        expect(subject).to redirect_to(admin_root_path)
        expect_status(302)
      end
    end
  end

  describe 'POST#create' do
    subject { post :create, params: params }

    let(:params) do
      {
        session: {
          phone: phone,
          password: password
        }
      }
    end

    let(:phone) { '+79095673421' }
    let(:password) { 'secure' }

    context 'with valid params' do
      it 'authenticates admin' do
        expect(subject).to redirect_to(admin_root_path)
        expect_status(302)
        expect(assigns(:admin)).to eq(admin)
        expect(session[:administartor_id]).to eq(admin.id)
        expect(flash[:success]).to eq('Добро пожаловать')
      end

      context 'when phone starts with 8' do
        let(:phone) { '89095673421' }

        it 'authenticates admin' do
          expect(subject).to redirect_to(admin_root_path)
          expect_status(302)
          expect(assigns(:admin)).to eq(admin)
          expect(session[:administartor_id]).to eq(admin.id)
          expect(flash[:success]).to eq('Добро пожаловать')
        end
      end

      context 'when phone starts with 7' do
        let(:phone) { '79095673421' }

        it 'authenticates admin' do
          expect(subject).to redirect_to(admin_root_path)
          expect_status(302)
          expect(assigns(:admin)).to eq(admin)
          expect(session[:administartor_id]).to eq(admin.id)
          expect(flash[:success]).to eq('Добро пожаловать')
        end
      end

      context 'when phone without prefix' do
        let(:phone) { '9095673421' }

        it 'authenticates admin' do
          expect(subject).to redirect_to(admin_root_path)
          expect_status(302)
          expect(assigns(:admin)).to eq(admin)
          expect(session[:administartor_id]).to eq(admin.id)
          expect(flash[:success]).to eq('Добро пожаловать')
        end
      end
    end

    context 'when invalid phone' do
      let(:phone) { '+79095673422' }

      it 'doesn\'t authenticate admin' do
        expect(subject).to render_template(:new)
        expect_status(200)
        expect(assigns(:admin)).to eq(nil)
        expect(session[:administartor_id]).to eq(nil)
        expect(flash[:error]).to eq('Нэ-а, что-то не так')
      end
    end

    context 'when invalid password' do
      let(:password) { 'fakepass' }

      it 'doesn\'t authenticate admin' do
        expect(subject).to render_template(:new)
        expect_status(200)
        expect(assigns(:admin)).to eq(admin)
        expect(session[:administartor_id]).to eq(nil)
        expect(flash[:error]).to eq('Нэ-а, что-то не так')
      end
    end
  end
end
