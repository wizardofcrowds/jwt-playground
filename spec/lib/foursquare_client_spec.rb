require 'rails_helper'

RSpec.describe FoursquareClient do
  before do
    @original_client_id = FoursquareClient.client_id
    @original_client_secret = FoursquareClient.client_secret
    FoursquareClient.client_id = 'client'
    FoursquareClient.client_secret = 'secret'
  end

  after do
    FoursquareClient.client_id = @original_client_id
    FoursquareClient.client_secret = @original_client_secret
  end

  describe '#connection' do
    it 'should be a HttpClient with keep alive being 15 seconds' do
      connection = FoursquareClient.connection

      expect(connection).to be_kind_of(HTTPClient)
      expect(connection.keep_alive_timeout).to eq(15)
    end
  end

  describe FoursquareClient::VenueSearch do
    it 'blah' do
      # WebMock.allow_net_connect!
      response_body=<<-RESPONSE
      {"meta":{"code":200,"requestId":"6101f8338eeecb43430b3f9b"},"response":{"venues":[{"id":"509ee5bbe4b0f56d613db4a9","name":"BXL Zoute","location":{"address":"50 W 22nd St","crossStreet":"at 6th Ave","lat":40.74199959382342,"lng":-73.99258559759792,"labeledLatLngs":[{"label":"display","lat":40.74199959382342,"lng":-73.99258559759792},{"label":"entrance","lat":40.741813,"lng":-73.992567}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["50 W 22nd St (at 6th Ave)","New York, NY 10010","United States"]},"categories":[{"id":"52e81612bcbc57f1066b7a02","name":"Belgian Restaurant","pluralName":"Belgian Restaurants","shortName":"Belgian","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/food\/default_","suffix":".png"},"primary":true}],"delivery":{"id":"313791","url":"https:\/\/www.seamless.com\/menu\/bxl-zoute-50-w-22nd-st-new-york\/313791?affiliate=1131&utm_source=foursquare-affiliate-network&utm_medium=affiliate&utm_campaign=1131&utm_content=313791","provider":{"name":"seamless","icon":{"prefix":"https:\/\/fastly.4sqi.net\/img\/general\/cap\/","sizes":[40,50],"name":"\/delivery_provider_seamless_20180129.png"}}},"referralId":"v-1627519027","hasPerk":false},{"id":"53dd6133498eda7a37c14fec","name":"Tiger Schulmann's Mixed Martial Arts","location":{"address":"688 Avenue of the Americas, 2nd and 3rd Floor","crossStreet":"22nd Street","lat":40.742002214001474,"lng":-73.99344745905537,"labeledLatLngs":[{"label":"display","lat":40.742002214001474,"lng":-73.99344745905537}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["688 Avenue of the Americas, 2nd and 3rd Floor (22nd Street)","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d101941735","name":"Martial Arts School","pluralName":"Martial Arts Schools","shortName":"Martial Arts","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/shops\/gym_martialarts_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"5bf34fca018cbb002c99be4a","name":"Taïm","location":{"address":"64 W 22nd St","crossStreet":"at 6th Ave","lat":40.7422561970515,"lng":-73.99314380430064,"labeledLatLngs":[{"label":"display","lat":40.7422561970515,"lng":-73.99314380430064}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["64 W 22nd St (at 6th Ave)","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d10b941735","name":"Falafel Restaurant","pluralName":"Falafel Restaurants","shortName":"Falafel","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/food\/falafel_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"4be6ceb9bcef2d7fbd7405e5","name":"The Caroline","location":{"address":"60 W 23rd St","crossStreet":"6th ave","lat":40.74249105987339,"lng":-73.99262824277736,"labeledLatLngs":[{"label":"display","lat":40.74249105987339,"lng":-73.99262824277736}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["60 W 23rd St (6th ave)","New York, NY 10010","United States"]},"categories":[{"id":"4d954b06a243a5684965b473","name":"Residential Building (Apartment \/ Condo)","pluralName":"Residential Buildings (Apartments \/ Condos)","shortName":"Residential","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/building\/apartment_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"4c225ae47e85c9283ee5bb21","name":"Trader Joe's","location":{"address":"675 6th Ave","crossStreet":"at W 21st St","lat":40.741739139805574,"lng":-73.99365296900864,"labeledLatLngs":[{"label":"display","lat":40.741739139805574,"lng":-73.99365296900864},{"label":"entrance","lat":40.74184,"lng":-73.993793}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["675 6th Ave (at W 21st St)","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d118951735","name":"Grocery Store","pluralName":"Grocery Stores","shortName":"Grocery Store","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/shops\/food_grocery_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"591cdaf26f0aa22c76a53ff3","name":"Cote","location":{"address":"16 W 22nd St","lat":40.74127747314681,"lng":-73.99123217573167,"labeledLatLngs":[{"label":"display","lat":40.74127747314681,"lng":-73.99123217573167}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["16 W 22nd St","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d113941735","name":"Korean Restaurant","pluralName":"Korean Restaurants","shortName":"Korean","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/food\/korean_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"5faf0d486ebada162708f7e6","name":"Auntie Anne's\/Cinnabon","location":{"address":"686 Avenue of the Americas","lat":40.742706,"lng":-73.99279,"labeledLatLngs":[{"label":"display","lat":40.742706,"lng":-73.99279}],"postalCode":"10010","cc":"US","neighborhood":"Flatiron District","city":"New York","state":"NY","country":"United States","formattedAddress":["686 Avenue of the Americas","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d1c7941735","name":"Snack Place","pluralName":"Snack Places","shortName":"Snacks","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/food\/snacks_","suffix":".png"},"primary":true}],"delivery":{"id":"2258548","url":"https:\/\/www.seamless.com\/menu\/auntie-annes-and-cinnabon-688-6th-ave-new-york\/2258548?affiliate=1131&utm_source=foursquare-affiliate-network&utm_medium=affiliate&utm_campaign=1131&utm_content=2258548","provider":{"name":"seamless","icon":{"prefix":"https:\/\/fastly.4sqi.net\/img\/general\/cap\/","sizes":[40,50],"name":"\/delivery_provider_seamless_20180129.png"}}},"referralId":"v-1627519027","hasPerk":false},{"id":"4a881c9cf964a520310520e3","name":"Soon Beauty Lab West","location":{"address":"54 W 22nd St","crossStreet":"at 6th Ave.","lat":40.742051704386675,"lng":-73.99271377516129,"labeledLatLngs":[{"label":"display","lat":40.742051704386675,"lng":-73.99271377516129},{"label":"entrance","lat":40.741891,"lng":-73.992702}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["54 W 22nd St (at 6th Ave.)","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d110951735","name":"Salon \/ Barbershop","pluralName":"Salons \/ Barbershops","shortName":"Salon \/ Barbershop","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/shops\/salon_barber_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"4abc15a4f964a520518620e3","name":"The IMC Lab + Gallery","location":{"address":"56 W 22nd St Fl 6","crossStreet":"5th Ave","lat":40.74207101635607,"lng":-73.99259805679321,"labeledLatLngs":[{"label":"display","lat":40.74207101635607,"lng":-73.99259805679321}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["56 W 22nd St Fl 6 (5th Ave)","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d1e2931735","name":"Art Gallery","pluralName":"Art Galleries","shortName":"Art Gallery","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/arts_entertainment\/artgallery_","suffix":".png"},"primary":true}],"venuePage":{"id":"39133625"},"referralId":"v-1627519027","hasPerk":false},{"id":"4bfd3b828992a593a7c4abb0","name":"22 W 21st","location":{"lat":40.740683038911385,"lng":-73.99191849074394,"labeledLatLngs":[{"label":"display","lat":40.740683038911385,"lng":-73.99191849074394}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d130941735","name":"Building","pluralName":"Buildings","shortName":"Building","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/building\/default_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"4b2a9723f964a520e6ab24e3","name":"Duane Reade Express","location":{"address":"184 5th Ave","crossStreet":"at 23rd St.","lat":40.7414058,"lng":-73.9899264,"labeledLatLngs":[{"label":"display","lat":40.7414058,"lng":-73.9899264}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["184 5th Ave (at 23rd St.)","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d10f951735","name":"Pharmacy","pluralName":"Pharmacies","shortName":"Pharmacy","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/shops\/pharmacy_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"4f71cf66e4b09a1095f6d633","name":"Aurify Brands HQ","location":{"address":"56 W 22nd St","crossStreet":"6th Avenue","lat":40.74210763691991,"lng":-73.99269897675663,"labeledLatLngs":[{"label":"display","lat":40.74210763691991,"lng":-73.99269897675663}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["56 W 22nd St (6th Avenue)","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d124941735","name":"Office","pluralName":"Offices","shortName":"Office","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/building\/default_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"6063a91c538a2c5cb75e917d","name":"Life Time Fitness","location":{"address":"60 W 23rd St","lat":40.74307,"lng":-73.992404,"labeledLatLngs":[{"label":"display","lat":40.74307,"lng":-73.992404}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["60 W 23rd St","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d175941735","name":"Gym \/ Fitness Center","pluralName":"Gyms or Fitness Centers","shortName":"Gym \/ Fitness","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/building\/gym_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"5d4c6e7a3d4ea60008af0ebc","name":"Chick-fil-A","location":{"address":"700 Avenue of the Americas","crossStreet":"at W 22nd St","lat":40.7423583,"lng":-73.9928843,"labeledLatLngs":[{"label":"display","lat":40.7423583,"lng":-73.9928843},{"label":"entrance","lat":40.742477,"lng":-73.992907}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["700 Avenue of the Americas (at W 22nd St)","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d16e941735","name":"Fast Food Restaurant","pluralName":"Fast Food Restaurants","shortName":"Fast Food","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/food\/fastfood_","suffix":".png"},"primary":true}],"delivery":{"id":"1945764","url":"https:\/\/www.seamless.com\/menu\/chick-fil-a-700-6th-ave-new-york\/1945764?affiliate=1131&utm_source=foursquare-affiliate-network&utm_medium=affiliate&utm_campaign=1131&utm_content=1945764","provider":{"name":"seamless","icon":{"prefix":"https:\/\/fastly.4sqi.net\/img\/general\/cap\/","sizes":[40,50],"name":"\/delivery_provider_seamless_20180129.png"}}},"referralId":"v-1627519027","hasPerk":false},{"id":"573363c2498eb18e283007f8","name":"Bite","location":{"address":"62 W 22nd St","crossStreet":"at 6th Ave","lat":40.742135733688905,"lng":-73.993066263182,"labeledLatLngs":[{"label":"display","lat":40.742135733688905,"lng":-73.993066263182}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["62 W 22nd St (at 6th Ave)","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d1c0941735","name":"Mediterranean Restaurant","pluralName":"Mediterranean Restaurants","shortName":"Mediterranean","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/food\/mediterranean_","suffix":".png"},"primary":true}],"delivery":{"id":"323312","url":"https:\/\/www.seamless.com\/menu\/bite-22-62-w-22nd-st-new-york\/323312?affiliate=1131&utm_source=foursquare-affiliate-network&utm_medium=affiliate&utm_campaign=1131&utm_content=323312","provider":{"name":"seamless","icon":{"prefix":"https:\/\/fastly.4sqi.net\/img\/general\/cap\/","sizes":[40,50],"name":"\/delivery_provider_seamless_20180129.png"}}},"referralId":"v-1627519027","hasPerk":false},{"id":"5a187743ccad6b307315e6fe","name":"Foursquare HQ","location":{"address":"50 W 23rd St","crossStreet":"btwn 5th & 6th Ave","lat":40.742058823215544,"lng":-73.9918041229248,"labeledLatLngs":[{"label":"display","lat":40.742058823215544,"lng":-73.9918041229248}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["50 W 23rd St (btwn 5th & 6th Ave)","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d125941735","name":"Tech Startup","pluralName":"Tech Startups","shortName":"Tech Startup","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/shops\/technology_","suffix":".png"},"primary":true}],"venuePage":{"id":"489091283"},"referralId":"v-1627519027","hasPerk":false},{"id":"5e13660927e8d400088de582","name":"Life Time (Life Time 23rd Street Preview Gallery)","location":{"address":"60 W 23rd Street","lat":40.74249511,"lng":-73.99281522,"labeledLatLngs":[{"label":"display","lat":40.74249511,"lng":-73.99281522}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["60 W 23rd Street","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d176941735","name":"Gym","pluralName":"Gyms","shortName":"Gym","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/building\/gym_","suffix":".png"},"primary":true}],"venuePage":{"id":"576161664"},"referralId":"v-1627519027","hasPerk":false},{"id":"5a3821fedd8442139c8c75db","name":"Rokt","location":{"address":"50 W 23rd St","crossStreet":"btwn 5th & 6th Ave","lat":40.7422,"lng":-73.991654,"labeledLatLngs":[{"label":"display","lat":40.7422,"lng":-73.991654}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["50 W 23rd St (btwn 5th & 6th Ave)","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d125941735","name":"Tech Startup","pluralName":"Tech Startups","shortName":"Tech Startup","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/shops\/technology_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"5165a5e7e4b02c4aa0cfe6c8","name":"Fairway Market","location":{"address":"766 Avenue of the Americas","crossStreet":"btwn W 25th & 26th St","lat":40.7445918940299,"lng":-73.9915032471721,"labeledLatLngs":[{"label":"display","lat":40.7445918940299,"lng":-73.9915032471721}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["766 Avenue of the Americas (btwn W 25th & 26th St)","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d118951735","name":"Grocery Store","pluralName":"Grocery Stores","shortName":"Grocery Store","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/shops\/food_grocery_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"5d866403029a4a00077d0876","name":"Paris Baguette","location":{"address":"700 Avenue of the Americas","lat":40.742401,"lng":-73.992976,"labeledLatLngs":[{"label":"display","lat":40.742401,"lng":-73.992976}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["700 Avenue of the Americas","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d16a941735","name":"Bakery","pluralName":"Bakeries","shortName":"Bakery","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/food\/bakery_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"5e658a744a58800008c011f8","name":"Nuts Factory","location":{"lat":40.742403,"lng":-73.993005,"labeledLatLngs":[{"label":"display","lat":40.742403,"lng":-73.993005}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d117951735","name":"Candy Store","pluralName":"Candy Stores","shortName":"Candy Store","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/shops\/candystore_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"5ad60252840fc26fc4c31db6","name":"Dailymotion","location":{"address":"50 W 23rd St","crossStreet":"btwn 5th & 6th Ave","lat":40.742243,"lng":-73.991859,"labeledLatLngs":[{"label":"display","lat":40.742243,"lng":-73.991859}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["50 W 23rd St (btwn 5th & 6th Ave)","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d125941735","name":"Tech Startup","pluralName":"Tech Startups","shortName":"Tech Startup","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/shops\/technology_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"5ae509d231fd14002cb6aa10","name":"BodyRok","location":{"address":"10 W 18th St","crossStreet":"2nd Fl","lat":40.73889889731482,"lng":-73.99283072633699,"labeledLatLngs":[{"label":"display","lat":40.73889889731482,"lng":-73.99283072633699}],"postalCode":"10011","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["10 W 18th St (2nd Fl)","New York, NY 10011","United States"]},"categories":[{"id":"4bf58dd8d48988d175941735","name":"Gym \/ Fitness Center","pluralName":"Gyms or Fitness Centers","shortName":"Gym \/ Fitness","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/building\/gym_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"4d8ea211d265236a30bd0f17","name":"48 West 22nd Street","location":{"lat":40.74208932720949,"lng":-73.99241777260337,"labeledLatLngs":[{"label":"display","lat":40.74208932720949,"lng":-73.99241777260337}],"cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["New York, NY","United States"]},"categories":[{"id":"4d954b06a243a5684965b473","name":"Residential Building (Apartment \/ Condo)","pluralName":"Residential Buildings (Apartments \/ Condos)","shortName":"Residential","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/building\/apartment_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"4d8e67086174a0938ed2c7e3","name":"The Caroline Gameroom","location":{"address":"60 W 23rd St","crossStreet":"at 5th Ave","lat":40.742229,"lng":-73.992823,"labeledLatLngs":[{"label":"display","lat":40.742229,"lng":-73.992823}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["60 W 23rd St (at 5th Ave)","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d1e7941735","name":"Playground","pluralName":"Playgrounds","shortName":"Playground","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/parks_outdoors\/playground_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"5df646e36a4f110008325ee3","name":"The Caroline Fitness Center","location":{"lat":40.742001,"lng":-73.992721,"labeledLatLngs":[{"label":"display","lat":40.742001,"lng":-73.992721}],"postalCode":"10011","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["New York, NY 10011","United States"]},"categories":[{"id":"4bf58dd8d48988d175941735","name":"Gym \/ Fitness Center","pluralName":"Gyms or Fitness Centers","shortName":"Gym \/ Fitness","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/building\/gym_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"58b077d6fc73d40cf7378173","name":"Foursquare Roof Deck","location":{"address":"50 W 23rd St Fl 12","lat":40.74194518885131,"lng":-73.9918779410063,"labeledLatLngs":[{"label":"display","lat":40.74194518885131,"lng":-73.9918779410063}],"postalCode":"10010","cc":"US","neighborhood":"Union Square","city":"New York","state":"NY","country":"United States","formattedAddress":["50 W 23rd St Fl 12","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d133951735","name":"Roof Deck","pluralName":"Roof Decks","shortName":"Roof Deck","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/travel\/hotel_roofdeck_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"5235f52811d28190e1fc0173","name":"Living Fresh Mens Spa","location":{"lat":40.74191155767711,"lng":-73.99236764718636,"labeledLatLngs":[{"label":"display","lat":40.74191155767711,"lng":-73.99236764718636}],"cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["New York, NY","United States"]},"categories":[{"id":"4bf58dd8d48988d1ed941735","name":"Spa","pluralName":"Spas","shortName":"Spa","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/shops\/spa_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"5eff6c12fe54d700074e7f01","name":"Edens Gelato","location":{"lat":40.742501,"lng":-73.992995,"labeledLatLngs":[{"label":"display","lat":40.742501,"lng":-73.992995}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d16a941735","name":"Bakery","pluralName":"Bakeries","shortName":"Bakery","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/food\/bakery_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false},{"id":"5c5b906ba6031c002c5f5eb4","name":"Taïm Falafel And Smoothie Bar","location":{"address":"64 W 22nd St","lat":40.741981506347656,"lng":-73.99314880371094,"labeledLatLngs":[{"label":"display","lat":40.741981506347656,"lng":-73.99314880371094}],"postalCode":"10010","cc":"US","city":"New York","state":"NY","country":"United States","formattedAddress":["64 W 22nd St","New York, NY 10010","United States"]},"categories":[{"id":"4bf58dd8d48988d128941735","name":"Cafeteria","pluralName":"Cafeterias","shortName":"Cafeteria","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/education\/cafeteria_","suffix":".png"},"primary":true}],"referralId":"v-1627519027","hasPerk":false}],"confident":false,"geocode":{"what":"","where":"new york ny","feature":{"cc":"US","name":"New York","displayName":"New York, NY, United States","matchedName":"New York, NY, United States","highlightedName":"<b>New York<\/b>, <b>NY<\/b>, United States","woeType":7,"slug":"new-york-city-new-york","id":"geonameid:5128581","longId":"72057594043056517","geometry":{"center":{"lat":40.742185,"lng":-73.992602},"bounds":{"ne":{"lat":40.882214,"lng":-73.907},"sw":{"lat":40.679548,"lng":-74.047285}}}},"parents":[]}}}
      RESPONSE
      stub_request(:get, 'https://api.foursquare.com/v2/venues/search?category_id=&client_id=client&client_secret=secret&keyword=Totto&near=New%20York,%20NY&v=20210701').
         with(
           headers: {
            'Accept'=>'*/*'
           }).
         to_return(status: 200, body: response_body, headers: {})
      search = FoursquareClient::VenueSearch.new(near: 'New York, NY', keyword: 'Totto')

      expect(search.execute).to eq(JSON.parse response_body)
    end
  end
end
