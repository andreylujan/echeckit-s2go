# -*- encoding : utf-8 -*-
class RemoveIconFromSubsections < ActiveRecord::Migration
  def change
    remove_column :subsections, :icon, :text
  end
end
