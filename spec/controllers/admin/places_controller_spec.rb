# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Admin::PlacesController, type: :controller do
  let(:admin) { create(:administrator) }
  let!(:place) { create(:place, author: admin) }

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
        place: {
          name: name,
          description: 'amaizing place',
          latitude: 25.67859,
          longitude: 67.32456
        }
      }
    end

    let(:name) { 'new cozy place' }

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
        it 'creates new place' do
          expect { subject }.to change { ::Place.count }.by(1)
          expect_status(302)
          expect(response).to redirect_to %i[admin places]
          expect(flash[:success]).to eq('Место создано')
        end
      end

      context 'with invalid params' do
        let(:name) { nil }

        it 'doesn\'t create new place' do
          expect { subject }.not_to change { ::Place.count }
          expect_status(200)
          expect(response).to render_template(:new)
          expect(flash[:error]).to eq('Не удалось создать место')
        end
      end
    end
  end

  describe 'GET#edit' do
    subject { get :edit, params: { id: place.id } }

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
        id: place.id,
        place: {
          name: name,
          description: 'new place desc',
          latitude: 25.67859,
          longitude: 67.32456
        }
      }
    end

    let(:name) { 'new name' }

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
        it 'updates place' do
          expect { subject }.to change { place.reload.name }.to('new name')
            .and change { place.description }.to('new place desc')
            .and change { place.lonlat.latitude }.to(25.67859)

          expect_status(302)
          expect(response).to redirect_to %i[admin places]
          expect(flash[:success]).to eq('Место обновлёно')
        end
      end

      context 'with invalid params' do
        let(:name) { nil }

        it 'doesn\'t update place' do
          expect { subject }.to not_change { place.reload.name }
            .and not_change { place.description }
            .and not_change { place.lonlat.latitude }
            .and not_change { place.lonlat.longitude }

          expect_status(200)
          expect(response).to render_template(:edit)
          expect(flash[:error]).to eq('Не удалось обновить место')
        end
      end
    end
  end

  describe 'DELETE#destroy' do
    subject { delete :destroy, params: { id: place.id } }

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
        it 'deletes place' do
          expect { subject }.to change { ::Place.count }.by(-1)

          expect_status(302)
          expect(response).to redirect_to %i[admin places]
          expect(flash[:success]).to eq('Место удалёно')
        end
      end
    end
  end
end
