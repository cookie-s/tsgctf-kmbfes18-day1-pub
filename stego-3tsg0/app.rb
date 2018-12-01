require 'stringio'

require 'sinatra/base'

class Enumerator
  def self.concat(*enums)
    self.new do |y|
      enums.each do |e|
        e.each {|x| y << x }
      end
    end
  end
end

class TSG < Sinatra::Base
  TOP = File.open("top.html", &:read).freeze
  FLAG = IO.binread('flag').freeze
  get '/' do
    headers "Transfer-Encoding" => "chunked"

    ss = StringIO.new TOP
    stream do |s|
      Enumerator.concat(FLAG.bytes, [TOP.size, 0]).each do |b|
        t = ss.read(b)
        s << "%x\r\n" % t.bytesize
        s << t
        s << "\r\n"
      end
    end
  end
end
