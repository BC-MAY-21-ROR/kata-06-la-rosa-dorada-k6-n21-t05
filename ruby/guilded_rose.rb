# frozen_string_literal: true

# Class GuildedRose to update_quality
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      name = item.name
      quality = item.quality
      sell_in = item.sell_in
      max_quality = 50
      if (name != 'Aged Brie') && (name != 'Backstage passes to a TAFKAL80ETC concert')
        quality -= 1 if quality.positive? && (name != 'Sulfuras, Hand of Ragnaros')
        
      elsif quality < max_quality
        quality += 1
        if name == 'Backstage passes to a TAFKAL80ETC concert'
          quality += 1 if sell_in < 11 && (quality < max_quality)
          quality += 1 if sell_in < 6 && (quality < max_quality)
        end
      end

      sell_in -= 1 if name != 'Sulfuras, Hand of Ragnaros'

      if sell_in.negative?
        if name != 'Aged Brie'
          if name != 'Backstage passes to a TAFKAL80ETC concert'
            quality -= 1 if quality.positive? && (name != 'Sulfuras, Hand of Ragnaros')
          else
            quality -= quality
          end
        elsif quality < max_quality
          quality += 1
        end
      end
      item.quality = quality
      item.sell_in = sell_in
    end
  end
end

# Class Item to initialize
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
