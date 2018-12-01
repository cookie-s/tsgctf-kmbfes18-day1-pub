require 'yaml'
require 'sqlite3'

data = YAML.load(DATA.read)
dbfn = 'tsg.db'

File.delete dbfn
DB = SQLite3::Database.new dbfn

DB.execute 'DROP TABLE IF EXISTS members'
DB.execute 'DROP TABLE IF EXISTS fl4g'

DB.execute <<SQL
CREATE TABLE members(
  id integer PRIMARY KEY AUTOINCREMENT,
  name text,
  year integer,
  title text,
  url text
)
SQL

DB.execute <<SQL
CREATE TABLE fl4g (
  FLAG text
)
SQL

DB.execute %q!INSERT INTO fl4g(FLAG) VALUES('TSGCTF{159_MEMBERS_ARE_IN_SLACK}')!

def escape(x)
  x = x || ''
  x.gsub("'", "''")
end

data.reverse.each do |row|
  name, year, title, url = escape(row['name']), row['year'], escape(row['site-title']), escape(row['site-url'])
  sql = <<-SQL.chomp % [name, year, title, url]
  INSERT INTO members(name, year, title, url) VALUES('%s', %d, '%s', '%s')
  SQL
  DB.execute sql
end

__END__
- name: akouryy
  year: 2017
  site-title: akouryy.net
  site-url: https://akouryy.net/
- name: lmt_swallow
  year: 2017
  site-title: shift-js.info
  site-url: https://shift-js.info/
- name: nano
  year: 2017
  site-title:
  site-url:
- name: screenflip
  year: 2017
  site-title:
  site-url:
- name: fiord
  year: 2017
  site-title: アルゴリズマーの備忘録
  site-url: http://hyoga.hatenablog.com/
- name: moratorium08
  year: 2016
  site-title: moragramming
  site-url: http://moraprogramming.hateblo.jp/
- name: Timo
  year: 2015
  site-title:
  site-url:
- name: hide
  year: 2016
  site-title:
  site-url:
- name: yozeke
  year: 2016
  site-title:
  site-url:
- name: cookies
  year: 2015
  site-title: cookies~~~~
  site-url: https://kcz.sh/
- name: yamaguchi
  year: 2015
  site-title: yamaguchi.txt
  site-url: http://yamaguchi-1024.hatenablog.com/
- name: satos
  year: 2015
  site-title: 忖度
  site-url: http://satos.hatenablog.jp/
- name: nolze
  year: 2013
  site-title: A602
  site-url: http://www.tsg.ne.jp/nolze/
- name: 博多市
  year: 2013
  site-title: 博多市総合案内所
  site-url: https://hakatashi.com/
- name: qnighy
  year: 2012
  site-title: quantified qnighy
  site-url: http://qnighy.github.io/
- name: zeptometer
  year: 2012
  site-title: zeptolux
  site-url: http://zeptolux.dip.jp/
- name: 藁藁藁
  year: 2002
  site-title: 藁藁藁の世界
  site-url: http://www58.tok2.com/home/thewwworld/
- name: mitty
  year: 2002
  site-title: mitty.orz
  site-url: http://mitty.jp/
- name: タト
  year: 2001
  site-title: TT's Page
  site-url: http://www2.rosenet.ne.jp/~t-tachi/
- name: 伊達巻
  year: 2001
  site-title: 伊達巻自動巻込機
  site-url: http://www.twinkle-nightz.ne.jp/~datemaki/
- name: ROPPY
  year: 2001
  site-title: Shooting Star
  site-url: http://www12.plala.or.jp/roppy/
- name: Kaicho-
  year: 2001
  site-title: Kaicho- Lab.
  site-url: http://kaicho.dyndns.org/
- name: まめ
  year: 2000
  site-title: mame's web
  site-url: http://dame.dyndns.org/
- name: 飛廉
  year: 2000
  site-title: 漆黒の館
  site-url: http://hiren.s19.xrea.com/
- name: にしだ
  year: 2000
  site-title: Rez de chauss&eacute;e
  site-url: http://members.aol.com/thesirius/
- name: Tossy-2
  year: 2000
  site-title: Tossy-2 HomePage
  site-url: http://www.eva-01.jp/~eva-01/
- name: Tama
  year: 2000
  site-title: Tamaの部屋
  site-url: http://www.asahi-net.or.jp/~cd8t-aid/
- name: おてう
  year: 1999
  site-title: じゃんけん必勝法！
  site-url: http://www.geocities.co.jp/Playtown-Dice/5576/
- name: senchan
  year: 1999
  site-title: senchanの謎なおへや。
  site-url: http://yokohama.cool.ne.jp/senchan/
- name: nagyu
  year: 1999
  site-title: dp-lab
  site-url: http://www.dp-lab.org/
- name: あたぴぃ(38ATP)
  year: 1999
  site-title: あたぴぃのらくがきちょう Online
  site-url: http://blog.goo.ne.jp/atapy_spacekiss/
- name: むらき
  year: 1998
  site-title: sept's warehouse
  site-url: http://www.tsg.ne.jp/sept/
- name: ギャラ
  year: 1998
  site-title: Mud Hatter
  site-url: http://www2u.biglobe.ne.jp/~gyara/
- name: え〜す
  year: 1998
  site-title: ACE's web page on @NIFTY
  site-url: http://homepage1.nifty.com/cardcaptor/
- name: わいりー
  year: 1997
  site-title: D-Field
  site-url: http://www.hakusan.tsg.ne.jp/~wairy/
- name: もりさわゆうな
  year: 1997
  site-title: BStyle = Lolita + Gothic 2nd Style
  site-url: http://goth.yuuna.jp/
- name: ぱらぐらふ
  year: 1997
  site-title: Nano domain
  site-url: http://www.hakusan.tsg.ne.jp/tjkawa/
- name: 高野商店支店
  year: 1997
  site-title: 支店さんのtopページ
  site-url: http://www.tsg.ne.jp/shiten/
- name: こんの
  year: 1997
  site-title: Home Page of Shunichi Konno
  site-url: http://www.tsg.ne.jp/~konno/
- name: 菊
  year: 1997
  site-title: 菊なページ
  site-url: http://as305.dyndns.org/~kik/
- name: 壱平
  year: 1997
  site-title: 壱平 のホーム
  site-url: http://www.t3.rim.or.jp/~ippei/
- name: knagano
  year: 1997
  site-title: knagano AT sodan DOT org
  site-url: http://www.sodan.org/~knagano/
- name: ItaO
  year: 1997
  site-title: 坂尾要祐の秘密基地!!
  site-url: http://www003.upp.so-net.ne.jp/ItaO/
- name: れい
  year: 1996
  site-title: Rei's Shed
  site-url: http://www.rei.to/
- name: ばんだい
  year: 1996
  site-title: Bandosoft
  site-url: http://www2.tky.3web.ne.jp/~bandai/
- name: 帝位簒奪ロボ
  year: 1996
  site-title: 帝位簒奪ロボのホームページ
  site-url: http://park14.wakwak.com/~robo/
- name: すーゆー
  year: 1996
  site-title: すーゆー/takas in Cyberland
  site-url: http://www.mfp.gr.jp/users/takas/
- name: HASM
  year: 1996
  site-title: Yutaka Sugawara's web site
  site-url: http://user.ecc.u-tokyo.ac.jp/~rr27105/ja/
- name: おおいわ
  year: 1995
  site-title: Homepage of Yutaka Oiwa
  site-url: http://www.yl.is.s.u-tokyo.ac.jp/~oiwa/
- name: sigma
  year: 1994
  site-title: ひぐぺん工房
  site-url: http://cgi32.plala.or.jp/higpen/gate.shtml
- name: SHIGE
  year: 1994
  site-title: besideu::blog
  site-url: http://besideu.jp/blog/
- name: Nishi
  year: 1994
  site-title: 西澤 信行のホームページ
  site-url: http://www.gavo.t.u-tokyo.ac.jp/~nishi/index-j.html
- name: NAO
  year: 1994
  site-title: 渡辺尚貴のホームページ
  site-url: http://www-cms.phys.s.u-tokyo.ac.jp/~naoki/
- name: GANA
  year: 1994
  site-title: GANAware
  site-url: http://www.ganaware.jp/
- name: あじ
  year: 1993
  site-title: AviUtlプラグイン置き場
  site-url: http://www.geocities.jp/aji_0/
- name: Zephyr
  year: 1993
  site-title: 八重樫 剛史 のホームページ
  site-url: http://www.jsk.t.u-tokyo.ac.jp/~takeshi/
- name: CRUX
  year: 1993
  site-title: CRUX'sゑぶ
  site-url: http://hpcgi1.nifty.com/crux/
- name: Applause
  year: 1993
  site-title: 寺川 愛印 の Homepage
  site-url: http://applause.elfmimi.jp/
- name: Makken
  year: 1992
  site-title: ひぐぺん工房
  site-url: http://cgi32.plala.or.jp/higpen/gate.shtml
- name: FUN
  year: 1992
  site-title: 小林正和の自己紹介
  site-url: http://hp.vector.co.jp/authors/VA012881/
- name: れろ
  year: 1991
  site-title: 脳内がらくた庫
  site-url: http://www.italk.ne.jp/~mina/
- name: TEA
  year: 1991
  site-title: Sadakane's Homepage
  site-url: http://www.dais.is.tohoku.ac.jp/~sada/
- name: くりす
  year: 1990
  site-title: euc.JP
  site-url: http://euc.jp/
