# -*- encoding : utf-8 -*-
require File.join(File.dirname(__FILE__), 'question')
require 'watir-webdriver'
require 'digest/md5'

class KnowledgeBot
	# initial goal, hope to extend later
	@@website = 'http://bilenkazanir.mynet.com'

	def initialize()
		@b = Watir::Browser.new :ff
	end

	def login
		@b.goto @@website
		@b.link(text: 'Üye Girişi').click
		@b.text_field(name: 'u').set USERNAME
		@b.text_field(name: 'p').set PASSWORD
		@b.checkbox(name: 'rememberstatep').click
		@b.button(value: 'Giriş').click

		self
	end

	def learn(cnt=100)
		@b.goto 'http://bilenkazanir.mynet.com/yarisma/basla1.asp?categoryName=Genel%20K%FClt%FCr'

		while(cnt > 0) do 
			# html isn't validated, watir can't find
			qt = @b.strong(style: 'display:block;width:425px;').text
			qh = Digest::MD5.hexdigest(qt)
			qc = @b.tds(style:'padding-left:10px;', class:'txt12px').map {|td| td.text}
			
			q = Question.find_or_create_by_question_hash(question_text: qt, question_hash: qh, correct: '-', choices: qc)
			
			if q.correct.starts_with?('-')
				s = q.correct.gsub('-', '')
				if s.empty?
					c = ('a'..'d').to_a[rand(4)]
				else
					s = s.to_a
					ss = ('a'..'d').to_a.reject {|x| s.contains(x)}
					c = ss[rand(ss.length)]
				end
				@b.input(src: 'http://img3.mynet.com.tr/bilenkazanir/cvp-' + c + '.gif').click
				if @b.image(src: 'http://img.mynet.com.tr/general/blank.gif').nil?
					q.correct += c
					cnt -= 1
					@b.input(src: 'http://img3.mynet.com.tr/bilenkazanir/new-icons/genel-kultur.png').click		
				else
					q.correct = c
				end
				q.save
			else
				@b.input(src: 'http://img3.mynet.com.tr/bilenkazanir/cvp-' + q.correct + '.gif').click
			end
		end
	end

end

KnowledgeBot.new.login.learn(3)