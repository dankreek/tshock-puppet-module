require 'spec_helper'
describe 'terraria' do

  context 'with defaults for all parameters' do
    it { should contain_class('terraria') }
  end
end
