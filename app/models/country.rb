class Country
  
  LIST = [
          {:currency=>"USD", :name=>"Afghanistan", :iso=>"AF"}, {:currency=>"USD", :name=>"Albania", :iso=>"AL"},
          {:currency=>"USD", :name=>"Algeria", :iso=>"DZ"}, {:currency=>"USD", :name=>"American Samoa", :iso=>"AS"},
          {:currency=>"EUR", :name=>"Andorra", :iso=>"AD"}, {:currency=>"USD", :name=>"Angola", :iso=>"AO"},
          {:currency=>"USD", :name=>"Anguilla", :iso=>"AI"}, {:currency=>"USD", :name=>"Antarctica", :iso=>"AQ"},
          {:currency=>"USD", :name=>"Antigua and Barbuda", :iso=>"AG"}, {:currency=>"USD", :name=>"Argentina", :iso=>"AR"},
          {:currency=>"USD", :name=>"Armenia", :iso=>"AM"}, {:currency=>"USD", :name=>"Aruba", :iso=>"AW"},
          {:currency=>"USD", :name=>"Australia", :iso=>"AU"}, {:currency=>"EUR", :name=>"Austria", :iso=>"AT"},
          {:currency=>"USD", :name=>"Azerbaijan", :iso=>"AZ"}, {:currency=>"USD", :name=>"The Bahamas", :iso=>"BS"},
          {:currency=>"USD", :name=>"Bahrain", :iso=>"BH"}, {:currency=>"USD", :name=>"Bangladesh", :iso=>"BD"},
          {:currency=>"USD", :name=>"Barbados", :iso=>"BB"}, {:currency=>"USD", :name=>"Belarus", :iso=>"BY"},
          {:currency=>"EUR", :name=>"Belgium", :iso=>"BE"}, {:currency=>"USD", :name=>"Belize", :iso=>"BZ"},
          {:currency=>"USD", :name=>"Benin", :iso=>"BJ"}, {:currency=>"USD", :name=>"Bermuda", :iso=>"BM"},
          {:currency=>"USD", :name=>"Bhutan", :iso=>"BT"}, {:currency=>"USD", :name=>"Bolivia", :iso=>"BO"},
          {:currency=>"USD", :name=>"Bosnia and Herzegovina", :iso=>"BA"}, {:currency=>"USD", :name=>"Botswana", :iso=>"BW"},
          {:currency=>"USD", :name=>"Bouvet Island", :iso=>"BV"}, {:currency=>"USD", :name=>"Brazil", :iso=>"BR"},
          {:currency=>"USD", :name=>"British Indian Ocean Territory", :iso=>"IO"}, {:currency=>"USD", :name=>"British Virgin Islands", :iso=>"VG"},
          {:currency=>"USD", :name=>"Brunei Darussalam", :iso=>"BN"}, {:currency=>"USD", :name=>"Bulgaria", :iso=>"BG"},
          {:currency=>"USD", :name=>"Burkina Faso", :iso=>"BF"}, {:currency=>"USD", :name=>"Burma", :iso=>"MM"},
          {:currency=>"USD", :name=>"Burundi", :iso=>"BI"}, {:currency=>"USD", :name=>"Cambodia", :iso=>"KH"},
          {:currency=>"USD", :name=>"Cameroon", :iso=>"CM"}, {:currency=>"USD", :name=>"Canada", :iso=>"CA"},
          {:currency=>"USD", :name=>"Cape Verde", :iso=>"CV"}, {:currency=>"USD", :name=>"Cayman Islands", :iso=>"KY"},
          {:currency=>"USD", :name=>"Central African Republic", :iso=>"CF"}, {:currency=>"USD", :name=>"Chad", :iso=>"TD"},
          {:currency=>"USD", :name=>"Chile", :iso=>"CL"}, {:currency=>"USD", :name=>"China", :iso=>"CN"},
          {:currency=>"USD", :name=>"Christmas Island", :iso=>"CX"}, {:currency=>"USD", :name=>"Cocos (Keeling) Islands", :iso=>"CC"},
          {:currency=>"USD", :name=>"Colombia", :iso=>"CO"}, {:currency=>"USD", :name=>"Comoros", :iso=>"KM"},
          {:currency=>"USD", :name=>"Congo, Democratic Republic of the", :iso=>"CD"}, {:currency=>"USD", :name=>"Congo, Republic of the", :iso=>"CG"},
          {:currency=>"USD", :name=>"Cook Islands", :iso=>"CK"}, {:currency=>"USD", :name=>"Costa Rica", :iso=>"CR"},
          {:currency=>"USD", :name=>"Cote d'Ivoire", :iso=>"CI"}, {:currency=>"USD", :name=>"Croatia", :iso=>"HR"},
          {:currency=>"USD", :name=>"Cuba", :iso=>"CU"}, {:currency=>"EUR", :name=>"Cyprus", :iso=>"CY"},
          {:currency=>"USD", :name=>"Czech Republic", :iso=>"CZ"}, {:currency=>"USD", :name=>"Denmark", :iso=>"DK"},
          {:currency=>"USD", :name=>"Djibouti", :iso=>"DJ"}, {:currency=>"USD", :name=>"Dominica", :iso=>"DM"},
          {:currency=>"USD", :name=>"Dominican Republic", :iso=>"DO"}, {:currency=>"USD", :name=>"East Timor", :iso=>"TL"},
          {:currency=>"USD", :name=>"Ecuador", :iso=>"EC"}, {:currency=>"USD", :name=>"Egypt", :iso=>"EG"},
          {:currency=>"USD", :name=>"El Salvador", :iso=>"SV"}, {:currency=>"USD", :name=>"Equatorial Guinea", :iso=>"GQ"},
          {:currency=>"USD", :name=>"Eritrea", :iso=>"ER"}, {:currency=>"EUR", :name=>"Estonia", :iso=>"EE"},
          {:currency=>"USD", :name=>"Ethiopia", :iso=>"ET"}, {:currency=>"USD", :name=>"Falkland Islands (Islas Malvinas)", :iso=>"FK"}, {:currency=>"USD", :name=>"Faroe Islands", :iso=>"FO"}, {:currency=>"USD", :name=>"Fiji", :iso=>"FJ"}, {:currency=>"EUR", :name=>"Finland", :iso=>"FI"}, {:currency=>"EUR", :name=>"France", :iso=>"FR"}, {:currency=>"USD", :name=>"French Guiana", :iso=>"GF"}, {:currency=>"USD", :name=>"French Polynesia", :iso=>"PF"}, {:currency=>"USD", :name=>"French Southern and Antarctic Lands", :iso=>"TF"}, {:currency=>"USD", :name=>"Gabon", :iso=>"GA"}, {:currency=>"USD", :name=>"The Gambia", :iso=>"GM"}, {:currency=>"USD", :name=>"Georgia", :iso=>"GE"}, {:currency=>"EUR", :name=>"Germany", :iso=>"DE"}, {:currency=>"USD", :name=>"Ghana", :iso=>"GH"}, {:currency=>"USD", :name=>"Gibraltar", :iso=>"GI"}, {:currency=>"EUR", :name=>"Greece", :iso=>"GR"}, {:currency=>"USD", :name=>"Greenland", :iso=>"GL"}, {:currency=>"USD", :name=>"Grenada", :iso=>"GD"}, {:currency=>"USD", :name=>"Guadeloupe", :iso=>"GP"}, {:currency=>"USD", :name=>"Guam", :iso=>"GU"}, {:currency=>"USD", :name=>"Guatemala", :iso=>"GT"}, {:currency=>"USD", :name=>"Guinea", :iso=>"GN"}, {:currency=>"USD", :name=>"Guinea-Bissau", :iso=>"GW"}, {:currency=>"USD", :name=>"Guyana", :iso=>"GY"}, {:currency=>"USD", :name=>"Haiti", :iso=>"HT"}, {:currency=>"USD", :name=>"Heard Island and McDonald Islands", :iso=>"HM"}, {:currency=>"USD", :name=>"Holy See (Vatican City)", :iso=>"VA"}, {:currency=>"USD", :name=>"Honduras", :iso=>"HN"}, {:currency=>"USD", :name=>"Hong Kong (SAR)", :iso=>"HK"}, {:currency=>"USD", :name=>"Hungary", :iso=>"HU"}, {:currency=>"USD", :name=>"Iceland", :iso=>"IS"}, {:currency=>"USD", :name=>"India", :iso=>"IN"}, {:currency=>"USD", :name=>"Indonesia", :iso=>"ID"}, {:currency=>"USD", :name=>"Iran", :iso=>"IR"}, {:currency=>"USD", :name=>"Iraq", :iso=>"IQ"}, {:currency=>"EUR", :name=>"Ireland", :iso=>"IE"}, {:currency=>"USD", :name=>"Israel", :iso=>"IL"}, {:currency=>"EUR", :name=>"Italy", :iso=>"IT"}, {:currency=>"USD", :name=>"Jamaica", :iso=>"JM"}, {:currency=>"USD", :name=>"Japan", :iso=>"JP"}, {:currency=>"USD", :name=>"Jordan", :iso=>"JO"}, {:currency=>"USD", :name=>"Kazakhstan", :iso=>"KZ"}, {:currency=>"USD", :name=>"Kenya", :iso=>"KE"}, {:currency=>"USD", :name=>"Kiribati", :iso=>"KI"}, {:currency=>"USD", :name=>"Korea, North", :iso=>"KP"}, {:currency=>"USD", :name=>"Korea, South", :iso=>"KR"}, {:currency=>"USD", :name=>"Kuwait", :iso=>"KW"}, {:currency=>"USD", :name=>"Kyrgyzstan", :iso=>"KG"}, {:currency=>"USD", :name=>"Laos", :iso=>"LA"}, {:currency=>"USD", :name=>"Latvia", :iso=>"LV"}, {:currency=>"USD", :name=>"Lebanon", :iso=>"LB"}, {:currency=>"USD", :name=>"Lesotho", :iso=>"LS"}, {:currency=>"USD", :name=>"Liberia", :iso=>"LR"}, {:currency=>"USD", :name=>"Libya", :iso=>"LY"}, {:currency=>"USD", :name=>"Liechtenstein", :iso=>"LI"}, {:currency=>"USD", :name=>"Lithuania", :iso=>"LT"}, {:currency=>"EUR", :name=>"Luxembourg", :iso=>"LU"}, {:currency=>"USD", :name=>"Macao", :iso=>"MO"}, {:currency=>"USD", :name=>"Macedonia, The Former Yugoslav Republic of", :iso=>"MK"}, {:currency=>"USD", :name=>"Madagascar", :iso=>"MG"}, {:currency=>"USD", :name=>"Malawi", :iso=>"MW"}, {:currency=>"USD", :name=>"Malaysia", :iso=>"MY"}, {:currency=>"USD", :name=>"Maldives", :iso=>"MV"}, {:currency=>"USD", :name=>"Mali", :iso=>"ML"}, {:currency=>"EUR", :name=>"Malta", :iso=>"MT"}, {:currency=>"USD", :name=>"Marshall Islands", :iso=>"MH"}, {:currency=>"USD", :name=>"Martinique", :iso=>"MQ"}, {:currency=>"USD", :name=>"Mauritania", :iso=>"MR"}, {:currency=>"USD", :name=>"Mauritius", :iso=>"MU"}, {:currency=>"USD", :name=>"Mayotte", :iso=>"YT"}, {:currency=>"USD", :name=>"Mexico", :iso=>"MX"}, {:currency=>"USD", :name=>"Micronesia, Federated States of", :iso=>"FM"}, {:currency=>"USD", :name=>"Moldova", :iso=>"MD"}, {:currency=>"EUR", :name=>"Monaco", :iso=>"MC"}, {:currency=>"USD", :name=>"Mongolia", :iso=>"MN"}, {:currency=>"USD", :name=>"Montserrat", :iso=>"MS"}, {:currency=>"USD", :name=>"Morocco", :iso=>"MA"}, {:currency=>"USD", :name=>"Mozambique", :iso=>"MZ"}, {:currency=>"USD", :name=>"Namibia", :iso=>"NA"}, {:currency=>"USD", :name=>"Nauru", :iso=>"NR"}, {:currency=>"USD", :name=>"Nepal", :iso=>"NP"}, {:currency=>"EUR", :name=>"Netherlands", :iso=>"NL"}, {:currency=>"USD", :name=>"Netherlands Antilles", :iso=>"AN"}, {:currency=>"USD", :name=>"New Caledonia", :iso=>"NC"}, {:currency=>"USD", :name=>"New Zealand", :iso=>"NZ"}, {:currency=>"USD", :name=>"Nicaragua", :iso=>"NI"}, {:currency=>"USD", :name=>"Niger", :iso=>"NE"}, {:currency=>"USD", :name=>"Nigeria", :iso=>"NG"}, {:currency=>"USD", :name=>"Niue", :iso=>"NU"}, {:currency=>"USD", :name=>"Norfolk Island", :iso=>"NF"}, {:currency=>"USD", :name=>"Northern Mariana Islands", :iso=>"MP"}, {:currency=>"USD", :name=>"Norway", :iso=>"NO"}, {:currency=>"USD", :name=>"Oman", :iso=>"OM"}, {:currency=>"USD", :name=>"Pakistan", :iso=>"PK"}, {:currency=>"USD", :name=>"Palau", :iso=>"PW"}, {:currency=>"USD", :name=>"Panama", :iso=>"PA"}, {:currency=>"USD", :name=>"Papua New Guinea", :iso=>"PG"}, {:currency=>"USD", :name=>"Paraguay", :iso=>"PY"}, {:currency=>"USD", :name=>"Peru", :iso=>"PE"}, {:currency=>"USD", :name=>"Philippines", :iso=>"PH"}, {:currency=>"USD", :name=>"Pitcairn Islands", :iso=>"PN"}, {:currency=>"USD", :name=>"Poland", :iso=>"PL"}, {:currency=>"EUR", :name=>"Portugal", :iso=>"PT"}, {:currency=>"USD", :name=>"Puerto Rico", :iso=>"PR"}, {:currency=>"USD", :name=>"Qatar", :iso=>"QA"}, {:currency=>"USD", :name=>"R", :iso=>"RE"}, {:currency=>"USD", :name=>"Romania", :iso=>"RO"}, {:currency=>"USD", :name=>"Russia", :iso=>"RU"}, {:currency=>"USD", :name=>"Rwanda", :iso=>"RW"}, {:currency=>"USD", :name=>"Saint Helena", :iso=>"SH"}, {:currency=>"USD", :name=>"Saint Kitts and Nevis", :iso=>"KN"}, {:currency=>"USD", :name=>"Saint Lucia", :iso=>"LC"}, {:currency=>"USD", :name=>"Saint Pierre and Miquelon", :iso=>"PM"}, {:currency=>"USD", :name=>"Saint Vincent and the Grenadines", :iso=>"VC"}, {:currency=>"USD", :name=>"Samoa", :iso=>"WS"}, {:currency=>"EUR", :name=>"San Marino", :iso=>"SM"}, {:currency=>"USD", :name=>"S", :iso=>"ST"}, {:currency=>"USD", :name=>"Saudi Arabia", :iso=>"SA"}, {:currency=>"USD", :name=>"Senegal", :iso=>"SN"}, {:currency=>"USD", :name=>"Seychelles", :iso=>"SC"}, {:currency=>"USD", :name=>"Sierra Leone", :iso=>"SL"}, {:currency=>"USD", :name=>"Singapore", :iso=>"SG"}, {:currency=>"EUR", :name=>"Slovakia", :iso=>"SK"}, {:currency=>"EUR", :name=>"Slovenia", :iso=>"SI"}, {:currency=>"USD", :name=>"Solomon Islands", :iso=>"SB"}, {:currency=>"USD", :name=>"Somalia", :iso=>"SO"}, {:currency=>"USD", :name=>"South Africa", :iso=>"ZA"}, {:currency=>"USD", :name=>"South Georgia and the South Sandwich Islands", :iso=>"GS"}, {:currency=>"EUR", :name=>"Spain", :iso=>"ES"}, {:currency=>"USD", :name=>"Sri Lanka", :iso=>"LK"}, {:currency=>"USD", :name=>"Sudan", :iso=>"SD"}, {:currency=>"USD", :name=>"Suriname", :iso=>"SR"}, {:currency=>"USD", :name=>"Svalbard", :iso=>"SJ"}, {:currency=>"USD", :name=>"Swaziland", :iso=>"SZ"}, {:currency=>"USD", :name=>"Sweden", :iso=>"SE"}, {:currency=>"USD", :name=>"Switzerland", :iso=>"CH"}, {:currency=>"USD", :name=>"Syria", :iso=>"SY"}, {:currency=>"USD", :name=>"Taiwan", :iso=>"TW"}, {:currency=>"USD", :name=>"Tajikistan", :iso=>"TJ"}, {:currency=>"USD", :name=>"Tanzania", :iso=>"TZ"}, {:currency=>"USD", :name=>"Thailand", :iso=>"TH"}, {:currency=>"USD", :name=>"Togo", :iso=>"TG"}, {:currency=>"USD", :name=>"Tokelau", :iso=>"TK"}, {:currency=>"USD", :name=>"Tonga", :iso=>"TO"}, {:currency=>"USD", :name=>"Trinidad and Tobago", :iso=>"TT"}, {:currency=>"USD", :name=>"Tunisia", :iso=>"TN"}, {:currency=>"USD", :name=>"Turkey", :iso=>"TR"}, {:currency=>"USD", :name=>"Turkmenistan", :iso=>"TM"}, {:currency=>"USD", :name=>"Turks and Caicos Islands", :iso=>"TC"}, {:currency=>"USD", :name=>"Tuvalu", :iso=>"TV"}, {:currency=>"USD", :name=>"Uganda", :iso=>"UG"}, {:currency=>"USD", :name=>"Ukraine", :iso=>"UA"}, {:currency=>"USD", :name=>"United Arab Emirates", :iso=>"AE"}, {:currency=>"GBP", :name=>"United Kingdom", :iso=>"GB"}, {:currency=>"USD", :name=>"United States", :iso=>"US"}, {:currency=>"USD", :name=>"United States Minor Outlying Islands", :iso=>"UM"}, {:currency=>"USD", :name=>"Uruguay", :iso=>"UY"}, {:currency=>"USD", :name=>"Uzbekistan", :iso=>"UZ"}, {:currency=>"USD", :name=>"Vanuatu", :iso=>"VU"}, {:currency=>"USD", :name=>"Venezuela", :iso=>"VE"}, {:currency=>"USD", :name=>"Vietnam", :iso=>"VN"}, {:currency=>"USD", :name=>"Virgin Islands", :iso=>"VI"}, {:currency=>"USD", :name=>"Wallis and Futuna", :iso=>"WF"}, {:currency=>"USD", :name=>"Western Sahara", :iso=>"EH"}, {:currency=>"USD", :name=>"Yemen", :iso=>"YE"}, {:currency=>"USD", :name=>"Yugoslavia", :iso=>"YU"}, {:currency=>"USD", :name=>"Zambia", :iso=>"ZM"}, {:currency=>"USD", :name=>"Zimbabwe", :iso=>"ZW"}, {:currency=>"USD", :name=>"Palestinian Territory, Occupied", :iso=>"PS"}]
  LIST_3 = [{:currency=>"USD", :name=>"Afghanistan", :iso=>"AFG"}, {:currency=>"USD", :name=>"Albania", :iso=>"ALB"}, {:currency=>"USD", :name=>"Algeria", :iso=>"DZA"}, {:currency=>"USD", :name=>"American Samoa", :iso=>"ASM"}, {:currency=>"EUR", :name=>"Andorra", :iso=>"AND"}, {:currency=>"USD", :name=>"Angola", :iso=>"AGO"}, {:currency=>"USD", :name=>"Anguilla", :iso=>"AIA"}, {:currency=>"USD", :name=>"Antarctica", :iso=>"ATA"}, {:currency=>"USD", :name=>"Antigua and Barbuda", :iso=>"ATG"}, {:currency=>"USD", :name=>"Argentina", :iso=>"ARG"}, {:currency=>"USD", :name=>"Armenia", :iso=>"ARM"}, {:currency=>"USD", :name=>"Aruba", :iso=>"ABW"}, {:currency=>"USD", :name=>"Ashmore and Cartier", :iso=>"-- "}, {:currency=>"USD", :name=>"Australia", :iso=>"AUS"}, {:currency=>"EUR", :name=>"Austria", :iso=>"AUT"}, {:currency=>"USD", :name=>"Azerbaijan", :iso=>"AZE"}, {:currency=>"USD", :name=>"The Bahamas", :iso=>"BHS"}, {:currency=>"USD", :name=>"Bahrain", :iso=>"BHR"}, {:currency=>"USD", :name=>"Baker Island", :iso=>"-- "}, {:currency=>"USD", :name=>"Bangladesh", :iso=>"BGD"}, {:currency=>"USD", :name=>"Barbados", :iso=>"BRB"}, {:currency=>"USD", :name=>"Bassas da India", :iso=>"-- "}, {:currency=>"USD", :name=>"Belarus", :iso=>"BLR"}, {:currency=>"EUR", :name=>"Belgium", :iso=>"BEL"}, {:currency=>"USD", :name=>"Belize", :iso=>"BLZ"}, {:currency=>"USD", :name=>"Benin", :iso=>"BEN"}, {:currency=>"USD", :name=>"Bermuda", :iso=>"BMU"}, {:currency=>"USD", :name=>"Bhutan", :iso=>"BTN"}, {:currency=>"USD", :name=>"Bolivia", :iso=>"BOL"}, {:currency=>"USD", :name=>"Bosnia and Herzegovina", :iso=>"BIH"}, {:currency=>"USD", :name=>"Botswana", :iso=>"BWA"}, {:currency=>"USD", :name=>"Bouvet Island", :iso=>"BVT"}, {:currency=>"USD", :name=>"Brazil", :iso=>"BRA"}, {:currency=>"USD", :name=>"British Indian Ocean Territory", :iso=>"IOT"}, {:currency=>"USD", :name=>"British Virgin Islands", :iso=>"VGB"}, {:currency=>"USD", :name=>"Brunei Darussalam", :iso=>"BRN"}, {:currency=>"USD", :name=>"Bulgaria", :iso=>"BGR"}, {:currency=>"USD", :name=>"Burkina Faso", :iso=>"BFA"}, {:currency=>"USD", :name=>"Burma", :iso=>"MMR"}, {:currency=>"USD", :name=>"Burundi", :iso=>"BDI"}, {:currency=>"USD", :name=>"Cambodia", :iso=>"KHM"}, {:currency=>"USD", :name=>"Cameroon", :iso=>"CMR"}, {:currency=>"USD", :name=>"Canada", :iso=>"CAN"}, {:currency=>"USD", :name=>"Cape Verde", :iso=>"CPV"}, {:currency=>"USD", :name=>"Cayman Islands", :iso=>"CYM"}, {:currency=>"USD", :name=>"Central African Republic", :iso=>"CAF"}, {:currency=>"USD", :name=>"Chad", :iso=>"TCD"}, {:currency=>"USD", :name=>"Chile", :iso=>"CHL"}, {:currency=>"USD", :name=>"China", :iso=>"CHN"}, {:currency=>"USD", :name=>"Christmas Island", :iso=>"CXR"}, {:currency=>"USD", :name=>"Clipperton Island", :iso=>"-- "}, {:currency=>"USD", :name=>"Cocos (Keeling) Islands", :iso=>"CCK"}, {:currency=>"USD", :name=>"Colombia", :iso=>"COL"}, {:currency=>"USD", :name=>"Comoros", :iso=>"COM"}, {:currency=>"USD", :name=>"Congo, Democratic Republic of the", :iso=>"COD"}, {:currency=>"USD", :name=>"Congo, Republic of the", :iso=>"COG"}, {:currency=>"USD", :name=>"Cook Islands", :iso=>"COK"}, {:currency=>"USD", :name=>"Coral Sea Islands", :iso=>"-- "}, {:currency=>"USD", :name=>"Costa Rica", :iso=>"CRI"}, {:currency=>"USD", :name=>"Cote d'Ivoire", :iso=>"CIV"}, {:currency=>"USD", :name=>"Croatia", :iso=>"HRV"}, {:currency=>"USD", :name=>"Cuba", :iso=>"CUB"}, {:currency=>"EUR", :name=>"Cyprus", :iso=>"CYP"}, {:currency=>"USD", :name=>"Czech Republic", :iso=>"CZE"}, {:currency=>"USD", :name=>"Denmark", :iso=>"DNK"}, {:currency=>"USD", :name=>"Djibouti", :iso=>"DJI"}, {:currency=>"USD", :name=>"Dominica", :iso=>"DMA"}, {:currency=>"USD", :name=>"Dominican Republic", :iso=>"DOM"}, {:currency=>"USD", :name=>"East Timor", :iso=>"TLS"}, {:currency=>"USD", :name=>"Ecuador", :iso=>"ECU"}, {:currency=>"USD", :name=>"Egypt", :iso=>"EGY"}, {:currency=>"USD", :name=>"El Salvador", :iso=>"SLV"}, {:currency=>"USD", :name=>"Equatorial Guinea", :iso=>"GNQ"}, {:currency=>"USD", :name=>"Eritrea", :iso=>"ERI"}, {:currency=>"EUR", :name=>"Estonia", :iso=>"EST"}, {:currency=>"USD", :name=>"Ethiopia", :iso=>"ETH"}, {:currency=>"USD", :name=>"Europa Island", :iso=>"-- "}, {:currency=>"USD", :name=>"Falkland Islands (Islas Malvinas)", :iso=>"FLK"}, {:currency=>"USD", :name=>"Faroe Islands", :iso=>"FRO"}, {:currency=>"USD", :name=>"Fiji", :iso=>"FJI"}, {:currency=>"EUR", :name=>"Finland", :iso=>"FIN"}, {:currency=>"EUR", :name=>"France", :iso=>"FRA"}, {:currency=>"USD", :name=>"France, Metropolitan", :iso=>"-- "}, {:currency=>"USD", :name=>"French Guiana", :iso=>"GUF"}, {:currency=>"USD", :name=>"French Polynesia", :iso=>"PYF"}, {:currency=>"USD", :name=>"French Southern and Antarctic Lands", :iso=>"ATF"}, {:currency=>"USD", :name=>"Gabon", :iso=>"GAB"}, {:currency=>"USD", :name=>"The Gambia", :iso=>"GMB"}, {:currency=>"USD", :name=>"Gaza Strip", :iso=>"-- "}, {:currency=>"USD", :name=>"Georgia", :iso=>"GEO"}, {:currency=>"EUR", :name=>"Germany", :iso=>"DEU"}, {:currency=>"USD", :name=>"Ghana", :iso=>"GHA"}, {:currency=>"USD", :name=>"Gibraltar", :iso=>"GIB"}, {:currency=>"USD", :name=>"Glorioso Islands", :iso=>"-- "}, {:currency=>"EUR", :name=>"Greece", :iso=>"GRC"}, {:currency=>"USD", :name=>"Greenland", :iso=>"GRL"}, {:currency=>"USD", :name=>"Grenada", :iso=>"GRD"}, {:currency=>"USD", :name=>"Guadeloupe", :iso=>"GLP"}, {:currency=>"USD", :name=>"Guam", :iso=>"GUM"}, {:currency=>"USD", :name=>"Guatemala", :iso=>"GTM"}, {:currency=>"USD", :name=>"Guernsey", :iso=>"-- "}, {:currency=>"USD", :name=>"Guinea", :iso=>"GIN"}, {:currency=>"USD", :name=>"Guinea-Bissau", :iso=>"GNB"}, {:currency=>"USD", :name=>"Guyana", :iso=>"GUY"}, {:currency=>"USD", :name=>"Haiti", :iso=>"HTI"}, {:currency=>"USD", :name=>"Heard Island and McDonald Islands", :iso=>"HMD"}, {:currency=>"USD", :name=>"Holy See (Vatican City)", :iso=>"VAT"}, {:currency=>"USD", :name=>"Honduras", :iso=>"HND"}, {:currency=>"USD", :name=>"Hong Kong (SAR)", :iso=>"HKG"}, {:currency=>"USD", :name=>"Howland Island", :iso=>"-- "}, {:currency=>"USD", :name=>"Hungary", :iso=>"HUN"}, {:currency=>"USD", :name=>"Iceland", :iso=>"ISL"}, {:currency=>"USD", :name=>"India", :iso=>"IND"}, {:currency=>"USD", :name=>"Indonesia", :iso=>"IDN"}, {:currency=>"USD", :name=>"Iran", :iso=>"IRN"}, {:currency=>"USD", :name=>"Iraq", :iso=>"IRQ"}, {:currency=>"EUR", :name=>"Ireland", :iso=>"IRL"}, {:currency=>"USD", :name=>"Israel", :iso=>"ISR"}, {:currency=>"EUR", :name=>"Italy", :iso=>"ITA"}, {:currency=>"USD", :name=>"Jamaica", :iso=>"JAM"}, {:currency=>"USD", :name=>"Jan Mayen", :iso=>"-- "}, {:currency=>"USD", :name=>"Japan", :iso=>"JPN"}, {:currency=>"USD", :name=>"Jarvis Island", :iso=>"-- "}, {:currency=>"USD", :name=>"Jersey", :iso=>"-- "}, {:currency=>"USD", :name=>"Johnston Atoll", :iso=>"-- "}, {:currency=>"USD", :name=>"Jordan", :iso=>"JOR"}, {:currency=>"USD", :name=>"Juan de Nova Island", :iso=>"-- "}, {:currency=>"USD", :name=>"Kazakhstan", :iso=>"KAZ"}, {:currency=>"USD", :name=>"Kenya", :iso=>"KEN"}, {:currency=>"USD", :name=>"Kingman Reef", :iso=>"-- "}, {:currency=>"USD", :name=>"Kiribati", :iso=>"KIR"}, {:currency=>"USD", :name=>"Korea, North", :iso=>"PRK"}, {:currency=>"USD", :name=>"Korea, South", :iso=>"KOR"}, {:currency=>"USD", :name=>"Kuwait", :iso=>"KWT"}, {:currency=>"USD", :name=>"Kyrgyzstan", :iso=>"KGZ"}, {:currency=>"USD", :name=>"Laos", :iso=>"LAO"}, {:currency=>"USD", :name=>"Latvia", :iso=>"LVA"}, {:currency=>"USD", :name=>"Lebanon", :iso=>"LBN"}, {:currency=>"USD", :name=>"Lesotho", :iso=>"LSO"}, {:currency=>"USD", :name=>"Liberia", :iso=>"LBR"}, {:currency=>"USD", :name=>"Libya", :iso=>"LBY"}, {:currency=>"USD", :name=>"Liechtenstein", :iso=>"LIE"}, {:currency=>"USD", :name=>"Lithuania", :iso=>"LTU"}, {:currency=>"EUR", :name=>"Luxembourg", :iso=>"LUX"}, {:currency=>"USD", :name=>"Macao", :iso=>"MAC"}, {:currency=>"USD", :name=>"Macedonia, The Former Yugoslav Republic of", :iso=>"MKD"}, {:currency=>"USD", :name=>"Madagascar", :iso=>"MDG"}, {:currency=>"USD", :name=>"Malawi", :iso=>"MWI"}, {:currency=>"USD", :name=>"Malaysia", :iso=>"MYS"}, {:currency=>"USD", :name=>"Maldives", :iso=>"MDV"}, {:currency=>"USD", :name=>"Mali", :iso=>"MLI"}, {:currency=>"EUR", :name=>"Malta", :iso=>"MLT"}, {:currency=>"USD", :name=>"Man, Isle of", :iso=>"-- "}, {:currency=>"USD", :name=>"Marshall Islands", :iso=>"MHL"}, {:currency=>"USD", :name=>"Martinique", :iso=>"MTQ"}, {:currency=>"USD", :name=>"Mauritania", :iso=>"MRT"}, {:currency=>"USD", :name=>"Mauritius", :iso=>"MUS"}, {:currency=>"USD", :name=>"Mayotte", :iso=>"MYT"}, {:currency=>"USD", :name=>"Mexico", :iso=>"MEX"}, {:currency=>"USD", :name=>"Micronesia, Federated States of", :iso=>"FSM"}, {:currency=>"USD", :name=>"Midway Islands", :iso=>"-- "}, {:currency=>"USD", :name=>"Miscellaneous (French)", :iso=>"-- "}, {:currency=>"USD", :name=>"Moldova", :iso=>"MDA"}, {:currency=>"EUR", :name=>"Monaco", :iso=>"MCO"}, {:currency=>"USD", :name=>"Mongolia", :iso=>"MNG"}, {:currency=>"EUR", :name=>"Montenegro", :iso=>"-- "}, {:currency=>"USD", :name=>"Montserrat", :iso=>"MSR"}, {:currency=>"USD", :name=>"Morocco", :iso=>"MAR"}, {:currency=>"USD", :name=>"Mozambique", :iso=>"MOZ"}, {:currency=>"USD", :name=>"Myanmar", :iso=>"-- "}, {:currency=>"USD", :name=>"Namibia", :iso=>"NAM"}, {:currency=>"USD", :name=>"Nauru", :iso=>"NRU"}, {:currency=>"USD", :name=>"Navassa Island", :iso=>"-- "}, {:currency=>"USD", :name=>"Nepal", :iso=>"NPL"}, {:currency=>"EUR", :name=>"Netherlands", :iso=>"NLD"}, {:currency=>"USD", :name=>"Netherlands Antilles", :iso=>"ANT"}, {:currency=>"USD", :name=>"New Caledonia", :iso=>"NCL"}, {:currency=>"USD", :name=>"New Zealand", :iso=>"NZL"}, {:currency=>"USD", :name=>"Nicaragua", :iso=>"NIC"}, {:currency=>"USD", :name=>"Niger", :iso=>"NER"}, {:currency=>"USD", :name=>"Nigeria", :iso=>"NGA"}, {:currency=>"USD", :name=>"Niue", :iso=>"NIU"}, {:currency=>"USD", :name=>"Norfolk Island", :iso=>"NFK"}, {:currency=>"USD", :name=>"Northern Mariana Islands", :iso=>"MNP"}, {:currency=>"USD", :name=>"Norway", :iso=>"NOR"}, {:currency=>"USD", :name=>"Oman", :iso=>"OMN"}, {:currency=>"USD", :name=>"Pakistan", :iso=>"PAK"}, {:currency=>"USD", :name=>"Palau", :iso=>"PLW"}, {:currency=>"USD", :name=>"Palmyra Atoll", :iso=>"-- "}, {:currency=>"USD", :name=>"Panama", :iso=>"PAN"}, {:currency=>"USD", :name=>"Papua New Guinea", :iso=>"PNG"}, {:currency=>"USD", :name=>"Paracel Islands", :iso=>"-- "}, {:currency=>"USD", :name=>"Paraguay", :iso=>"PRY"}, {:currency=>"USD", :name=>"Peru", :iso=>"PER"}, {:currency=>"USD", :name=>"Philippines", :iso=>"PHL"}, {:currency=>"USD", :name=>"Pitcairn Islands", :iso=>"PCN"}, {:currency=>"USD", :name=>"Poland", :iso=>"POL"}, {:currency=>"EUR", :name=>"Portugal", :iso=>"PRT"}, {:currency=>"USD", :name=>"Puerto Rico", :iso=>"PRI"}, {:currency=>"USD", :name=>"Qatar", :iso=>"QAT"}, {:currency=>"USD", :name=>"R", :iso=>"REU"}, {:currency=>"USD", :name=>"Romania", :iso=>"ROU"}, {:currency=>"USD", :name=>"Russia", :iso=>"RUS"}, {:currency=>"USD", :name=>"Rwanda", :iso=>"RWA"}, {:currency=>"USD", :name=>"Saint Helena", :iso=>"SHN"}, {:currency=>"USD", :name=>"Saint Kitts and Nevis", :iso=>"KNA"}, {:currency=>"USD", :name=>"Saint Lucia", :iso=>"LCA"}, {:currency=>"USD", :name=>"Saint Pierre and Miquelon", :iso=>"SPM"}, {:currency=>"USD", :name=>"Saint Vincent and the Grenadines", :iso=>"VCT"}, {:currency=>"USD", :name=>"Samoa", :iso=>"WSM"}, {:currency=>"EUR", :name=>"San Marino", :iso=>"SMR"}, {:currency=>"USD", :name=>"S", :iso=>"STP"}, {:currency=>"USD", :name=>"Saudi Arabia", :iso=>"SAU"}, {:currency=>"USD", :name=>"Senegal", :iso=>"SEN"}, {:currency=>"USD", :name=>"Serbia", :iso=>"-- "}, {:currency=>"USD", :name=>"Serbia and Montenegro", :iso=>"-- "}, {:currency=>"USD", :name=>"Seychelles", :iso=>"SYC"}, {:currency=>"USD", :name=>"Sierra Leone", :iso=>"SLE"}, {:currency=>"USD", :name=>"Singapore", :iso=>"SGP"}, {:currency=>"EUR", :name=>"Slovakia", :iso=>"SVK"}, {:currency=>"EUR", :name=>"Slovenia", :iso=>"SVN"}, {:currency=>"USD", :name=>"Solomon Islands", :iso=>"SLB"}, {:currency=>"USD", :name=>"Somalia", :iso=>"SOM"}, {:currency=>"USD", :name=>"South Africa", :iso=>"ZAF"}, {:currency=>"USD", :name=>"South Georgia and the South Sandwich Islands", :iso=>"SGS"}, {:currency=>"EUR", :name=>"Spain", :iso=>"ESP"}, {:currency=>"USD", :name=>"Spratly Islands", :iso=>"-- "}, {:currency=>"USD", :name=>"Sri Lanka", :iso=>"LKA"}, {:currency=>"USD", :name=>"Sudan", :iso=>"SDN"}, {:currency=>"USD", :name=>"Suriname", :iso=>"SUR"}, {:currency=>"USD", :name=>"Svalbard", :iso=>"SJM"}, {:currency=>"USD", :name=>"Swaziland", :iso=>"SWZ"}, {:currency=>"USD", :name=>"Sweden", :iso=>"SWE"}, {:currency=>"USD", :name=>"Switzerland", :iso=>"CHE"}, {:currency=>"USD", :name=>"Syria", :iso=>"SYR"}, {:currency=>"USD", :name=>"Taiwan", :iso=>"TWN"}, {:currency=>"USD", :name=>"Tajikistan", :iso=>"TJK"}, {:currency=>"USD", :name=>"Tanzania", :iso=>"TZA"}, {:currency=>"USD", :name=>"Thailand", :iso=>"THA"}, {:currency=>"USD", :name=>"Togo", :iso=>"TGO"}, {:currency=>"USD", :name=>"Tokelau", :iso=>"TKL"}, {:currency=>"USD", :name=>"Tonga", :iso=>"TON"}, {:currency=>"USD", :name=>"Trinidad and Tobago", :iso=>"TTO"}, {:currency=>"USD", :name=>"Tromelin Island", :iso=>"-- "}, {:currency=>"USD", :name=>"Tunisia", :iso=>"TUN"}, {:currency=>"USD", :name=>"Turkey", :iso=>"TUR"}, {:currency=>"USD", :name=>"Turkmenistan", :iso=>"TKM"}, {:currency=>"USD", :name=>"Turks and Caicos Islands", :iso=>"TCA"}, {:currency=>"USD", :name=>"Tuvalu", :iso=>"TUV"}, {:currency=>"USD", :name=>"Uganda", :iso=>"UGA"}, {:currency=>"USD", :name=>"Ukraine", :iso=>"UKR"}, {:currency=>"USD", :name=>"United Arab Emirates", :iso=>"ARE"}, {:currency=>"GBP", :name=>"United Kingdom", :iso=>"GBR"}, {:currency=>"USD", :name=>"United States", :iso=>"USA"}, {:currency=>"USD", :name=>"United States Minor Outlying Islands", :iso=>"UMI"}, {:currency=>"USD", :name=>"Uruguay", :iso=>"URY"}, {:currency=>"USD", :name=>"Uzbekistan", :iso=>"UZB"}, {:currency=>"USD", :name=>"Vanuatu", :iso=>"VUT"}, {:currency=>"USD", :name=>"Venezuela", :iso=>"VEN"}, {:currency=>"USD", :name=>"Vietnam", :iso=>"VNM"}, {:currency=>"USD", :name=>"Virgin Islands", :iso=>"VIR"}, {:currency=>"USD", :name=>"Virgin Islands (UK)", :iso=>"-- "}, {:currency=>"USD", :name=>"Virgin Islands (US)", :iso=>"-- "}, {:currency=>"USD", :name=>"Wake Island", :iso=>"-- "}, {:currency=>"USD", :name=>"Wallis and Futuna", :iso=>"WLF"}, {:currency=>"USD", :name=>"West Bank", :iso=>"-- "}, {:currency=>"USD", :name=>"Western Sahara", :iso=>"ESH"}, {:currency=>"USD", :name=>"Western Samoa", :iso=>"-- "}, {:currency=>"USD", :name=>"World", :iso=>"-- "}, {:currency=>"USD", :name=>"Yemen", :iso=>"YEM"}, {:currency=>"USD", :name=>"Yugoslavia", :iso=>"YUG"}, {:currency=>"USD", :name=>"Zaire", :iso=>"-- "}, {:currency=>"USD", :name=>"Zambia", :iso=>"ZWB"}, {:currency=>"USD", :name=>"Zimbabwe", :iso=>"ZWE"}, {:currency=>"USD", :name=>"Palestinian Territory, Occupied", :iso=>"PSE"}]
  
  def self.find_by_country_code(code)
    LIST.select {|c| c[:iso] == code }.first || LIST.first rescue LIST.first
  end
  
  def self.curr_code_to_symbol(code)
    case code
      when 'USD' : '$'
      when 'EUR' : '€'
      when 'GBP' : '£'
      else '$'
    end
  end
end