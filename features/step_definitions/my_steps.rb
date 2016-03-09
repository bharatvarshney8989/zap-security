#encoding: UTF-8

Then(/^I should be able to see security warnings$/) do
  response = JSON.parse RestClient.get "http://#{$zap_proxy}:#{$zap_proxy_port}/json/core/view/alerts"
  events = response['alerts']
  high_risks = events.select{|x| x['risk'] == 'High'}
  high_count = high_risks.size
  medium_count = events.select{|x| x['risk'] == 'Medium'}.size
  low_count = events.select{|x| x['risk'] == 'Low'}.size
  informational_count = events.select{|x| x['risk'] == 'Informational'}.size

  if high_count > 0
    high_risks.each { |x| p x['alert'] }
  end

  expect(high_count).to eq 0

  site = Capybara.app_host
  response = JSON.parse RestClient.get "http://#{$zap_proxy}:#{$zap_proxy_port}/json/core/view/alerts",
      params: { zapapiformat: 'JSON', baseurl: site }
  response['alerts'].each { |x| p "#{x['alert']} risk level: #{x['risk']}"}
end

Given(/^I launch owasp zap for a scan$/) do
  launch_owasp_zap
end

When(/^I perform some journeys on my site$/) do
  visit ''
  page.driver.browser.manage.window.maximize
  find_by_id('q').set 'lg g4'
  find('button.grd2').click
  find_by_id('PrList').find('div.p', match: :first)
  find_by_id('pf1').set '100'
  find_by_id('pf2').set '1000'
  find('button.grd1').click
  find_by_id('PrList').find('li.firstRow', match: :first).find('div.p').click
  find('tr.first', match: :first)
  sleep 20
end