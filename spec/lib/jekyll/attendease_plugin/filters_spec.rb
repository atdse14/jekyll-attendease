require 'spec_helper'

# Error reading file /Users/patrick/work/jekyll-attendease/spec/lib/jekyll/attendease_plugin/fixtures/page.html: No such file or directory @ rb_sysopen - /Users/patrick/work/jekyll-attendease/spec/fixtures/Users/patrick/work/jekyll-attendease/spec/lib/jekyll/attendease_plugin/fixtures/page.html
RSpec.describe "Jekyll Attendease filters" do
  let(:site) { build_site }
  let(:page) { Jekyll::Page.new(site, fixtures_path.to_s, '', 'page.html') }
  let(:page_data) { page.data['foo'] }

  def render(content)
    ::Liquid::Template.parse(content).render({'page' => page.data})
  end

  context "{{ 'foo Bar bat' | slugify %}" do
    subject { render("{{ 'foo Bar bat' | slugify }}") }
    it { is_expected.to eq "foo_bar_bat" }
  end

  context "{{ page.foo | json %}" do
    subject { render("{{ page.foo | json }}") }
    it { is_expected.to eq(page_data.to_json) }
  end
end

