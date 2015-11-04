require 'spec_helper'

describe 'drupal' do

  let(:facts) { { 
    :osfamily => 'Debian',
    :operatingsystem => 'Ubuntu', 
    :lsbdistid => 'Ubuntu',
    :lsbdistcodename => 'Ubuntu',
  } }

  it { should compile.with_all_deps }

end
