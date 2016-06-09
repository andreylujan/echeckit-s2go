# -*- encoding : utf-8 -*-
class AddPdfToReport < ActiveRecord::Migration
  def change
    add_column :reports, :pdf, :text
  end
end
