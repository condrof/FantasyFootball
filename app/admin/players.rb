ActiveAdmin.register Player do  
  collection_action :zeroPlayerPoints, :method => :get do
    @players=Player.find(:all)
    @players.each do |player|
      player.update_attributes(:points=>0)
    end
    redirect_to admin_players_path, :notice => "PLAYERS POINTS SET TO 0!"
  end
  
  collection_action :deletePlayers, :method => :get do
    @players=Player.find(:all)
    @players.each do |player|
      player.destroy
    end
    redirect_to admin_players_path, :notice => "PLAYERS DELETED"
  end
  
  collection_action :updateBackPlayers, :method => :get do
    
    url="http://fantasyfootball.telegraph.co.uk/premierleague/select-team"
    website = Nokogiri::HTML(open(url))
    
    elements=website.xpath('//*[@id="list-GK"]/table/tr')
    
    arr = []
    elements.each do |row|
      x=row.xpath('td')
      name = x[0].text
      club = x[1].text
      @player=Player.find_by_name_and_club(name,club)
      arr=x[7].text.split("|")
      score=arr[1].split("/")   
      cards=arr[3].split("/") 
      clean_sheets = arr[2].split("/")
      goals=arr[4]
        
      @player.update_attributes(:points => arr[0].to_i, :value=>x[2].text.to_f, :games=>score[0].to_i, :part_appearances=>score[1], :goals=>goals.to_i  )
      @player.update_attributes(:yellows=>cards[0], :reds=>cards[1], :clean_sheets=> clean_sheets[0], :part_clean_sheets=>clean_sheets[1]  )
      #@player.penalties_saved = arr[2]     
    end 
    
    elements=website.xpath('//*[@id="list-DEF"]/table/tr')
    
    arr = []
    elements.each do |row|
      x=row.xpath('td')
      name = x[0].text
      club = x[1].text
      @player=Player.find_by_name_and_club(name,club)
      arr=x[7].text.split("|")
      score=arr[1].split("/")   
      cards=arr[3].split("/") 
      clean_sheets = arr[4].split("/")
      goals=arr[4]
        
      @player.update_attributes(:points => arr[0].to_i, :value=>x[2].text.to_f, :games=>score[0].to_i, :part_appearances=>score[1], :goals=>goals.to_i )
      @player.update_attributes(:yellows=>cards[0], :reds=>cards[1], :clean_sheets=> clean_sheets[0], :part_clean_sheets=>clean_sheets[1]  )
      #@player.penalties_saved = arr[2]     
    end  
      redirect_to admin_players_path, :notice => "PLAYERS UPDATED"
  end

  collection_action :updateForwardPlayers, :method => :get do
   url="http://fantasyfootball.telegraph.co.uk/premierleague/select-team"
   website = Nokogiri::HTML(open(url))
   elements=website.xpath('//*[@id="list-MID"]/table/tr')
   arr = []
    elements.each do |row|
      x=row.xpath('td')
      name = x[0].text
      club = x[1].text
      @player=Player.find_by_name_and_club(name,club)
      arr=x[7].text.split("|")
      score=arr[1].split("/")   
      cards=arr[4].split("/") 
      goals=arr[2]
      kcs = arr[3]
        
      @player.update_attributes(:points => arr[0].to_i, :value=>x[2].text.to_f, :games=>score[0].to_i, :part_appearances=>score[1], :goals=>goals.to_i )
      @player.update_attributes(:yellows=>cards[0], :reds=>cards[1], :key_contributions => kcs  )
    end  
    
   elements=website.xpath('//*[@id="list-STR"]/table/tr')
   arr = []
    elements.each do |row|
      x=row.xpath('td')
      name = x[0].text
      club = x[1].text
      @player=Player.find_by_name_and_club(name,club)
      arr=x[7].text.split("|")
      score=arr[1].split("/")   
      cards=arr[4].split("/") 
      goals=arr[2]
    kcs = arr[3]
        
      @player.update_attributes(:points => arr[0].to_i, :value=>x[2].text.to_f, :games=>score[0].to_i, :part_appearances=>score[1], :goals=>goals.to_i )
      @player.update_attributes(:yellows=>cards[0], :reds=>cards[1], :key_contributions => kcs  )
    end  
       redirect_to admin_players_path, :notice => "PLAYERS UPDATED"
  end   
    

  collection_action :updatePlayerPoints, :method => :get do
    @players=Player.find(:all)
    @players.each do |player|
      player.points=((player.goals.to_i*3) || 0)
      player.update_attributes(:points => player.points)
    end
    redirect_to admin_players_path, :notice => "PLAYER POINTS SUCCESSFULLY UPDATED!"
  end
  
  collection_action :createBackPlayer, :method => :get do
    url="http://fantasyfootball.telegraph.co.uk/premierleague/select-team"
    website = Nokogiri::HTML(open(url))
    elements=website.xpath('//*[@id="list-GK"]/table/tr')
    elements.each do |row|
          x=row.xpath('td')
          name=x[0].text
          club=x[1].text
          Player.create!(:position=>'Goalkeeper', :name=>name,:club=>club)
    end
       
    elements=website.xpath('//*[@id="list-DEF"]/table/tr')
    elements.each do |row|
          x=row.xpath('td')
          name=x[0].text
          club=x[1].text
          Player.create!(:position=>'Defender', :name=>name,:club=>club,)
    end
    redirect_to admin_players_path, :notice => "PLAYERS SUCCESSFULLY CREATED!"
  end
 
  collection_action :createForwardPlayer, :method => :get do
    url="http://fantasyfootball.telegraph.co.uk/premierleague/select-team"
    website = Nokogiri::HTML(open(url))
    elements=website.xpath('//*[@id="list-MID"]/table/tr')
    elements.each do |row|
          x=row.xpath('td')
          name=x[0].text
          club=x[1].text
          Player.create!(:position=>'Midfield', :name=>name,:club=>club)
    end
    
    elements=website.xpath('//*[@id="list-STR"]/table/tr')
    elements.each do |row|
          x=row.xpath('td')
          name=x[0].text
          club=x[1].text
          Player.create!(:position=>'Forward', :name=>name,:club=>club)
    end
    redirect_to admin_players_path, :notice => "PLAYERS SUCCESSFULLY CREATED!"
  end
  
  collection_action :samplePlayer, :method => :get do
        100.times do |p|
      player_name = Faker::Name.name
      club = "Club"
      goals = rand(30)
      position = "Midfield"
      points = 0

    Player.create!(:name => player_name,
                   :club => club,
                   :goals => goals,
                   :position => position,
                   :points => points)
    end
    
        redirect_to admin_players_path, :notice => "PLAYERS SUCCESSFULLY CREATED!"
  end
  
  index do
    column :name
    column :club
    column :position
    column :goals
    column :yellows
    column :reds
    column :value
    column :points
    default_actions
  end
end
