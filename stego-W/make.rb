require 'rmagick'

img = Magick::ImageList.new ARGV.shift || (raise ArgumentError)
cols, rows = img.columns, img.rows

himg = Magick::ImageList.new.tap{|x| x.new_image cols, rows, Magick::SolidFill.new('black')}
Magick::Draw.new {
  {'font_family=': 'ricty', 'pointsize=': 16, 'font_weight=': Magick::BoldWeight}.each{|a|send *a}
}.annotate(himg, 0, 0, 80, 25, DATA.tap(&:rewind).read){ self.fill = 'white' }

pxs, hpxs = [img, himg].map{|img| img.get_pixels(0, 0, cols, rows)}
[pxs, hpxs].transpose.each_with_index do |(px1, px2), idx|
  bs, i, j = 8, idx / cols, idx % cols
  r, g = ((i/bs + j/bs) % 2), ((idx / (cols * rows / 2)) * rand(2))
  b = r ^ g ^ px2.red[15]

  px1.red   &= ~0x100; px1.red   ^= r << 8
  px1.green &= ~0x100; px1.green ^= g << 8
  px1.blue  &= ~0x100; px1.blue  ^= b << 8
end

img.store_pixels(0, 0, cols, rows, pxs)
img.write("problem.png")

__END__
TSGCTF{'RGB'.bytes.inject(&:^).chr}
Note: You don't have to evaluate the flag.
