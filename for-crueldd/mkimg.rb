`rm -rf output`

`dd if=/dev/zero of=problem.img bs=8M count=1`
`chown cookies.cookies problem.img`
puts `mkfs.ext2 problem.img -b1024 -g4096 -N1024`
`mount problem.img mnt`

imgs = `ls imgs`.split("\n").map{|x| "imgs/%s" % x}

alnums = [*?a..?z,*?A..?Z,*?0..?9]
def alnums.randfn
  "%s" % 6.times.map{self[rand(size)]}.join
end

dirs = 50.times.map{alnums.randfn}
dirs.each do |dir|
  `mkdir mnt/#{dir}`
end

paths = []
900.times.each do
  src = imgs.sample
  dstfn = alnums.randfn
  dstpath = "%s/%s.png" % [dirs.sample, dstfn]
  `cp #{src} mnt/#{dstpath}`
  paths.push dstpath
end

flag_idx = rand(1000)
1000.times.each do |i|
  if i == flag_idx
    src = 'flag.png'
    dstfn = alnums.randfn
    dstpath = "%s/%s.png" % [dirs.sample, dstfn]
    `cp #{src} mnt/#{dstpath}`
    next
  end

  if [true, false].sample
    # cp
    src = imgs.sample
    dstfn = alnums.randfn
    dstpath = "%s/%s.png" % [dirs.sample, dstfn]
    `cp #{src} mnt/#{dstpath}`
    paths.push dstpath
  else
    # rm
    victim = paths.delete_at(rand paths.size)
    `rm mnt/#{victim}`
  end
end

`umount mnt`

puts `e2fsck problem.img -n`

`dd if=problem.img of=problem.img ibs=1024 obs=1024 count=1 skip=1 seek=4097 conv=notrunc`
`dd if=/dev/zero of=problem.img ibs=1024 obs=1024 count=1 seek=1 conv=notrunc`

puts
puts
puts

puts `e2fsck problem.img -n`
`cp problem.img tmp.img`
puts `e2fsck tmp.img -b4097 -y`

`mount tmp.img mnt -o ro`
puts `find mnt -type f | xargs sha1sum | fgrep $(sha1sum flag.png | cut -f1 -d' ')`
`umount mnt`

`foremost problem.img`
puts `find output -type f | xargs sha1sum | fgrep $(sha1sum flag.png | cut -f1 -d' ')`
