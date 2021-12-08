# frozen_string_literal: true

# Class GuildedRose to update_quality
class GildedRose
  def initialize(items)
    @items = items
    @max_quality = 50
  end

  def update_quality
    @items.each do |item|
      name = item.name
      quality = item.quality
      sell_in = item.sell_in
      next unless name != 'Sulfuras, Hand of Ragnaros'

      # call quality_rules
      # quality=quality_rules
      quality = quality_rules(name, quality, sell_in)
      # call sell_in_rules
      sell_in -= 1
      if sell_in.negative?
        sell_in = sell_in_rules(name, quality, sell_in)
      else
        item.quality = quality
      end
      item.sell_in = sell_in
    end
  end

  def quality_rules(name, quality, sell_in)
    if (name != 'Aged Brie') && (name != 'Backstage passes to a TAFKAL80ETC concert')
      quality -= 1 if quality.positive?

    elsif quality < @max_quality
      quality += 1
      if name == 'Backstage passes to a TAFKAL80ETC concert'
        quality += 1 if sell_in < 11 && (quality < @max_quality)
        quality += 1 if sell_in < 6 && (quality < @max_quality)
      end
    end
    quality
  end

  def sell_in_rules(name, quality, _sell_in)
    if name != 'Aged Brie'
      if name != 'Backstage passes to a TAFKAL80ETC concert'
        quality -= 1 if quality.positive?
      else
        quality -= quality
      end
    elsif quality < @max_quality
      quality += 1
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
