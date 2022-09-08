require 'rails_helper'

describe User do
  it "é valido quando contem o primeiro nome, ultimo nome e email" do
    user = User.new( firstname: 'Thiago', 
                     lastname: 'Fagundes', 
                     email: "Thiago@gatinho.com" )

    expect(user).to be_valid
  end

  it "Nao é valido quando o primeiro nome é nulo" do
    user = User.new( firstname: nil )
    user.valid?

    expect(user.errors[:firstname]).to include("can't be blank")
  end

  it "é invalido caso já exista um e-mail igual" do
    user = User.new( firstname: 'Thiago',
                     lastname: 'Fagundes',
                     email: '123@123.com' )
    user.save!
    user.valid?

    user2 = User.new( firstname: 'Benjamim',
                     lastname: 'Alberto',
                     email: '123@123.com' )
    user.save!
    user2.valid?
    expect(user2.errors[:email]).to include("has already been taken")
  end

  it "é invalido caso já exista um lastname vazio" do
    user = User.new( firstname: 'Thiago',
                     lastname: nil,
                     email: '123@123.com' )
    user.valid?

    expect(user.errors[:lastname]).to include( "can't be blank" )
  end

  it "é invalido caso já exista um email vazio" do
    user = User.new( firstname: 'Thiago',
                     lastname: 'Fagundes',
                     email: nil )
    user.valid?

    expect(user.errors[:email]).to include( "can't be blank" )
  end
end
