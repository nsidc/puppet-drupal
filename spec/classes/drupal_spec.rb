require 'spec_helper'

describe 'drupal' do

  let(:facts) { { :operatingsystem => 'Ubuntu' } }

  it { should compile.with_all_deps }

end
