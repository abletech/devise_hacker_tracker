require 'spec_helper'

describe HackerTracker do
  describe '.hacker?' do
    let(:ip_address){ '1.2.3.4' }

    before { stub_const("Devise", double(devise_config)) }

    subject(:is_hacker) { HackerTracker.hacker?(ip_address) }

    context "with a maximum of 2 accounts failed before locking" do
      let(:devise_config){ { maximum_attempts_per_ip: 1, maximum_accounts_attempted: 1, ip_block_time: 5.minutes, model_identifer_column_name: 'user_email' } }

      context 'with no existing sign in failures' do
        it "does not detect a hacker" do
          expect(is_hacker).to be false
        end
      end

      context 'with an existing recent failures' do
        before { create(:sign_in_failure) }

        it "detects a hacker" do
          expect(is_hacker).to be true
        end
      end

      context 'with an existing outdated failure' do
        before { create(:sign_in_failure, created_at: 6.minutes.ago.utc) }

        it "clears the outdated records" do
          expect{is_hacker}.to change{SignInFailure.count}.from(1).to(0)
        end

        it "does not detect a hacker" do
          expect(is_hacker).to be false
        end

        context 'and an existing recent failures' do
          before { create(:sign_in_failure) }

          it "clears the outdated records" do
            expect{is_hacker}.to change{SignInFailure.count}.from(2).to(1)
          end

          it "detects a hacker" do
            expect(is_hacker).to be true
          end
        end
      end
    end

    context "with a maximum of 2 accounts failed before locking" do
      let(:devise_config){ { maximum_attempts_per_ip: 1, maximum_accounts_attempted: 2, ip_block_time: 5.minutes, model_identifer_column_name: 'user_email' } }

      context 'with an a recent failures on only 1 account' do
        before { create(:sign_in_failure) }

        it "does not detect a hacker" do
          expect(is_hacker).to be false
        end
      end

      context 'with an 2 recent failures on only 1 account' do
        before do
          create(:sign_in_failure)
          create(:sign_in_failure)
        end

        it "does not detect a hacker" do
          expect(is_hacker).to be false
        end
      end

      context 'with an 2 recent failures on 2 accounts' do
        before do
          create(:sign_in_failure)
          create(:sign_in_failure, user_email: 'another@eg.com')
        end

        it "detects a hacker" do
          expect(is_hacker).to be true
        end
      end

    end
  end
end
