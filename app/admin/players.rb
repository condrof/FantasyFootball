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
    id=0
    elements.each do |row|
          x=row.xpath('td')
          name=x[0].text
          club=x[1].text
          id+=1
          Player.create!(:id=>id,:position=>'Goalkeeper', :name=>name,:club=>club)
    end
       
    elements=website.xpath('//*[@id="list-DEF"]/table/tr')
    elements.each do |row|
          x=row.xpath('td')
          name=x[0].text
          club=x[1].text
          id+=1
          Player.create!(:id=>id,:position=>'Defender', :name=>name,:club=>club)
    end
    redirect_to admin_players_path, :notice => "PLAYERS SUCCESSFULLY CREATED!"
  end
 
  collection_action :createForwardPlayer, :method => :get do
    id=Player.last.id + 1
    url="http://fantasyfootball.telegraph.co.uk/premierleague/select-team"
    website = Nokogiri::HTML(open(url))
    elements=website.xpath('//*[@id="list-MID"]/table/tr')
    elements.each do |row|
          x=row.xpath('td')
          name=x[0].text
          club=x[1].text
          id+=1
          Player.create!(:id=>id,:position=>'Midfield', :name=>name,:club=>club)
    end
    
    elements=website.xpath('//*[@id="list-STR"]/table/tr')
    elements.each do |row|
          x=row.xpath('td')
          name=x[0].text
          club=x[1].text
          id+=1
          Player.create!(:id=>id,:position=>'Forward', :name=>name,:club=>club)
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
    column :points
    default_actions
  end
end
