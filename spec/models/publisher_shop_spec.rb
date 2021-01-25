require 'rails_helper'
#PublisherShop spec
RSpec.describe PublisherShop, type: :model do

  describe '#update_books_sold_count' do

    context 'when shop_book exists' do
      let!(:publisher) { create :publisher }
      let!(:shop) { create :shop }
      let!(:book) { create :book, publisher: publisher }
      let!(:shop_book) { create :shop_book, shop: shop, book: book }

      it 'does not change #books_sold_count' do
        expect { method_call }.not_to change { instance.reload.books_sold_count }.from 0
      end

      context 'and it is of the same publisher and shop' do
        let(:publisher) { instance.publisher }
        let(:shop) { instance.shop }

        it 'updates #books_sold_count to equal shop_book#copies_sold' do
          expect { method_call }.to change { instance.reload.books_sold_count }
                                        .from(0)
                                        .to(shop_book.copies_sold)
        end

        context 'and there is another shop_book with the same publisher and shop' do
          let!(:another_book) { create :book, publisher: instance.publisher }
          let!(:another_shop_book) { create :shop_book, book: another_book, shop: instance.shop }

          it 'updates #books_sold_count to be the sum of #copies_sold of these shop_books' do
            expect { method_call }.to change { instance.reload.books_sold_count }
                                          .from(0)
                                          .to(shop_book.copies_sold + another_shop_book.copies_sold)
          end
        end
      end

      context "and it's publisher is the same" do
        let(:publisher) { instance.publisher }

        include_examples 'not changing #books_sold_count'
      end

      context "and it's shop is the same" do
        let(:shop) { instance.shop }

        include_examples 'not changing #books_sold_count'
      end
    end
  end
end
