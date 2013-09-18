require 'spec_helper'

describe User do
<<<<<<< HEAD
  pending "add some examples to (or delete) #{__FILE__}"
=======
  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }

  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
>>>>>>> ed5701fe367bd0e081152864b73f33b302fa3051
end
