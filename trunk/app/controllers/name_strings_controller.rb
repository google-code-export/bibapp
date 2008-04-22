class NameStringsController < ApplicationController
  make_resourceful do 
    build :all
    
    before :new, :edit do
      @name_string_authorities = NameString.find(:all, :conditions => ["id = authority_id"], :order => "name")
    end
    
    before :index do 
      @name_strings = NameString.find(:all, :order => "name", :limit => 10)
    end
    response_for :index do |format|
      format.html # index.html
      format.xml { render :xml => @name_strings.to_xml }
    end

    before :show do
      
    end
    
    response_for :show do |format|
      format.html # index.html
      format.xml { render :xml => @name_string.to_xml }
    end
  end
end