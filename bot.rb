# -*- encoding : utf-8 -*-
require File.join(File.dirname(__FILE__), 'question')
require 'mechanize'

class KnowledgeBot
	# initial goal, hope to extend later
	@@website = 'http://bilenkazanir.mynet.com'

	def initialize()
		@a = Mechanize.new
	end

	def login
		@a.get(@@website) do |page|
			login_page = @a.click(page.link_with(text: 'Üye Girişi'))

			# stop here since mechanize can't handle js

			# default_page = login_page.form_with(action: '') do |f|
			#	f.
			# end.click_button
		end

		self
	end

	def learn
		# start to learn
	end

end

KnowledgeBot.new.login.learn
