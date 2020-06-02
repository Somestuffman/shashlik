# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Admin::AdministratorsController, type: :controller do
  let(:admin) { create(:administrator) }

  describe 'GET#index' do
    subject { get :index }

    context 'when authenticated' do
      as_admin :admin

      it 'is ok' do
        subject
        expect_status(200)
        expect(response).to render_template(:index)
      end
    end

    context 'when unauthenticated' do
      it 'redirects to login page' do
        subject
        expect_status(302)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET#new' do
    subject { get :new }

    context 'when authenticated' do
      as_admin :admin

      it 'is ok' do
        subject
        expect_status(200)
        expect(response).to render_template(:new)
      end
    end

    context 'when unauthenticated' do
      it 'redirects to login page' do
        subject
        expect_status(302)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST#create' do
    subject { post :create, params: params }

    let(:params) do
      {
        administrator: {
          name: name,
          phone: phone,
          password: password
        }
      }
    end

    let(:name) { 'admin name' }
    let(:password) { 'mypass' }
    let(:phone) { '89037896539' }

    context 'when unauthenticated' do
      it 'redirects to login page' do
        subject
        expect_status(302)
        expect(response).to redirect_to root_path
      end
    end

    context 'when authenticated' do
      as_admin :admin

      context 'with valid params' do
        it 'creates new administrator' do
          expect { subject }.to change { ::Administrator.count }.by(1)
          expect_status(302)
          expect(response).to redirect_to %i[admin administrators]
          expect(flash[:success]).to eq('Администратор создан')
        end
      end

      context 'with invalid params' do
        let(:name) { nil }

        it 'doesn\'t create new administrator' do
          expect { subject }.not_to change { ::Administrator.count }
          expect_status(200)
          expect(response).to render_template(:new)
          expect(flash[:error]).to eq('Не удалось создать администратора')
        end
      end
    end
  end

  describe 'GET#edit' do
    subject { get :edit, params: { id: admin.id } }

    context 'when authenticated' do
      as_admin :admin

      it 'is ok' do
        subject
        expect_status(200)
        expect(response).to render_template(:edit)
      end
    end

    context 'when unauthenticated' do
      it 'redirects to login page' do
        subject
        expect_status(302)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PATCH#update' do
    subject { patch :update, params: params }

    let(:params) do
      {
        id: admin.id,
        administrator: {
          name: name,
          phone: phone,
          password: password
        }
      }
    end

    let(:name) { 'admin name' }
    let(:password) { 'mypass' }
    let(:phone) { '89037896539' }

    context 'when unauthenticated' do
      it 'redirects to login page' do
        subject
        expect_status(302)
        expect(response).to redirect_to root_path
      end
    end

    context 'when authenticated' do
      as_admin :admin

      context 'with valid params' do
        it 'updates administrator' do
          expect { subject }.to change { admin.reload.name }.to('admin name')
                                                            .and change { admin.phone }.to('+79037896539')

          expect(admin.reload.authenticate('mypass')).to be_truthy

          expect_status(302)
          expect(response).to redirect_to %i[admin administrators]
          expect(flash[:success]).to eq('Администратор обновлён')
        end
      end

      context 'with invalid params' do
        let(:name) { nil }

        it 'doesn\'t update administrator' do
          expect { subject }.to not_change { admin.reload.name }
            .and not_change { admin.phone }
            .and not_change { admin.password }

          expect_status(200)
          expect(response).to render_template(:edit)
          expect(flash[:error]).to eq('Не удалось обновить администратора')
        end
      end
    end
  end

  describe 'DELETE#destroy' do
    subject { delete :destroy, params: { id: admin.id } }

    context 'when unauthenticated' do
      it 'redirects to login page' do
        subject
        expect_status(302)
        expect(response).to redirect_to root_path
      end
    end

    context 'when authenticated' do
      as_admin :admin

      context 'with valid params' do
        it 'deletes administrator' do
          expect { subject }.to change { ::Administrator.count }.by(-1)

          expect_status(302)
          expect(response).to redirect_to %i[admin administrators]
          expect(flash[:success]).to eq('Администратор удалён')
        end
      end
    end
  end
end
