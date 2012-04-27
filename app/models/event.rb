# -*- encoding : utf-8 -*-
class Event < ActiveRecord::Base
  COUNTRY_LIST =  ['Afghanistan', 'Albania', 'Algeria', 'American Samoa', 'Andorra', 'Angola', 'Anguilla', 'Antarctica', 'Antigua And Barbuda', 'Argentina', 'Armenia', 'Aruba', 'Australia', 'Austria', 'Azerbaijan', 'Bahamas', 'Bahrain', 'Bangladesh', 'Barbados', 'Belarus', 'Belgium', 'Belize', 'Benin', 'Bermuda', 'Bhutan', 'Bolivia', 'Bosnia And Herzegovina', 'Botswana', 'Bouvet Island', 'Brazil', 'British Indian Ocean Territory', 'Brunei', 'Bulgaria', 'Burkina Faso', 'Burundi', 'Cambodia', 'Cameroon', 'Canada', 'Cape Verde', 'Cayman Islands', 'Central African Republic', 'Chad', 'Chile', 'China', 'Christmas Island', 'Cocos (Keeling) Islands', 'Columbia', 'Comoros', 'Congo', 'Cook Islands', 'Costa Rica', 'Cote D\'Ivorie (Ivory Coast)', 'Croatia (Hrvatska)', 'Cuba', 'Cyprus', 'Czech Republic', 'Democratic Republic Of Congo (Zaire)', 'Denmark', 'Djibouti', 'Dominica', 'Dominican Republic', 'East Timor', 'Ecuador', 'Egypt', 'El Salvador', 'Equatorial Guinea', 'Eritrea', 'Estonia', 'Ethiopia', 'Falkland Islands (Malvinas)', 'Faroe Islands', 'Fiji', 'Finland', 'France', 'France, Metropolitan', 'French Guinea', 'French Polynesia', 'French Southern Territories', 'Gabon', 'Gambia', 'Georgia', 'Germany', 'Ghana', 'Gibraltar', 'Greece', 'Greenland', 'Grenada', 'Guadeloupe', 'Guam', 'Guatemala', 'Guinea', 'Guinea-Bissau', 'Guyana', 'Haiti', 'Heard And McDonald Islands', 'Honduras', 'Hong Kong', 'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq', 'Ireland', 'Israel', 'Italy', 'Jamaica', 'Japan', 'Jordan', 'Kazakhstan', 'Kenya', 'Kiribati', 'Kuwait', 'Kyrgyzstan', 'Laos', 'Latvia', 'Lebanon', 'Lesotho', 'Liberia', 'Libya', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Macau', 'Macedonia', 'Madagascar', 'Malawi', 'Malaysia', 'Maldives', 'Mali', 'Malta', 'Marshall Islands', 'Martinique', 'Mauritania', 'Mauritius', 'Mayotte', 'Mexico', 'Micronesia', 'Moldova', 'Monaco', 'Mongolia', 'Montserrat', 'Morocco', 'Mozambique', 'Myanmar (Burma)', 'Namibia', 'Nauru', 'Nepal', 'Netherlands', 'Netherlands Antilles', 'New Caledonia', 'New Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'Niue', 'Norfolk Island', 'North Korea', 'Northern Mariana Islands', 'Norway', 'Oman', 'Pakistan', 'Palau', 'Panama', 'Papua New Guinea', 'Paraguay', 'Peru', 'Philippines', 'Pitcairn', 'Poland', 'Portugal', 'Puerto Rico', 'Qatar', 'Reunion', 'Romania', 'Russia', 'Rwanda', 'Saint Helena', 'Saint Kitts And Nevis', 'Saint Lucia', 'Saint Pierre And Miquelon', 'Saint Vincent And The Grenadines', 'San Marino', 'Sao Tome And Principe', 'Saudi Arabia', 'Senegal', 'Seychelles', 'Sierra Leone', 'Singapore', 'Slovak Republic', 'Slovenia', 'Solomon Islands', 'Somalia', 'South Africa', 'South Georgia And South Sandwich Islands', 'South Korea', 'Spain', 'Sri Lanka', 'Sudan', 'Suriname', 'Svalbard And Jan Mayen', 'Swaziland', 'Sweden', 'Switzerland', 'Syria', 'Taiwan', 'Tajikistan', 'Tanzania', 'Thailand', 'Togo', 'Tokelau', 'Tonga', 'Trinidad And Tobago', 'Tunisia', 'Turkey', 'Turkmenistan', 'Turks And Caicos Islands', 'Tuvalu', 'Uganda', 'Ukraine', 'United Arab Emirates', 'United Kingdom', 'United States', 'United States Minor Outlying Islands', 'Uruguay', 'Uzbekistan', 'Vanuatu', 'Vatican City (Holy See)', 'Venezuela', 'Vietnam', 'Virgin Islands (British)', 'Virgin Islands (US)', 'Wallis And Futuna Islands', 'Western Sahara', 'Western Samoa', 'Yemen', 'Yugoslavia', 'Zambia', 'Zimbabwe']
  DEPARTMENT_LIST = ["01 - Ain", "02 - Aisne", "03 - Allier", "04 - Alpes-de-Haute-Provence", "05 - Hautes-Alpes", "06 - Alpes-Maritimes", "07 - Ardèche", "08 - Ardennes", "09 - Ariège", "10 - Aube", "11 - Aude", "12 - Aveyron", "13 - Bouches-du-Rhône", "14 - Calvados", "15 - Cantal", "16 - Charente", "17 - Charente-Maritime", "18 - Cher", "19 - Corrèze", "2A - Corse-du-Sud", "2B - Haute-Corse", "21 - Côte-d'Or", "22 - Côtes-d'Armor", "23 - Creuse", "24 - Dordogne", "25 - Doubs", "26 - Drôme", "27 - Eure", "28 - Eure-et-Loir", "29 - Finistère", "30 - Gard", "31 - Haute-Garonne", "32 - Gers", "33 - Gironde", "34 - Hérault", "35 - Ille-et-Vilaine", "36 - Indre", "37 - Indre-et-Loire", "38 - Isère", "39 - Jura", "40 - Landes", "41 - Loir-et-Cher", "42 - Loire", "43 - Haute-Loire", "44 - Loire-Atlantique", "45 - Loiret", "46 - Lot", "47 - Lot-et-Garonne", "48 - Lozère", "49 - Maine-et-Loire", "50 - Manche", "51 - Marne", "52 - Haute-Marne", "53 - Mayenne", "54 - Meurthe-et-Moselle", "55 - Meuse", "56 - Morbihan", "57 - Moselle", "58 - Nièvre", "59 - Nord", "60 - Oise", "61 - Orne", "62 - Pas-de-Calais", "63 - Puy-de-Dôme", "64 - Pyrénées-Atlantiques", "65 - Hautes-Pyrénées", "66 - Pyrénées-Orientales", "67 - Bas-Rhin", "68 - Haut-Rhin", "69 - Rhône", "70 - Haute-Saône", "71 - Saône-et-Loire", "72 - Sarthe", "73 - Savoie", "74 - Haute-Savoie", "75 - Paris", "76 - Seine-Maritime", "77 - Seine-et-Marne", "78 - Yvelines", "79 - Deux-Sèvres", "80 - Somme", "81 - Tarn", "82 - Tarn-et-Garonne", "83 - Var", "84 - Vaucluse", "85 - Vendée", "86 - Vienne", "87 - Haute-Vienne", "88 - Vosges", "89 - Yonne", "90 - Territoire de Belfort", "91 - Essonne", "92 - Hauts-de-Seine", "93 - Seine-Saint-Denis", "94 - Val-de-Marne", "95 - Val-d'Oise"]
  scope :published, joins(:moderation_setting).where("moderation_settings.published = ?", true)
  scope :recent, order('created_at desc')
  scope :member_of_redaction, joins(:user).where("users.role = ? OR users.role = ?", "admin", "redactor")
  delegate :member_of_redaction?, :to => :user, :allow_nil => true, :prefix => :is_authored_by
  
  delegate :picture, :to => :presentation_picture, :allow_nil => true
  
  delegate :approve, :refuse, :pending_for_moderation, :to => :moderation_setting, :allow_nil => true
  delegate :published, :to => :moderation_setting, :allow_nil => true, :prefix => :is
  delegate :moderated, :to => :moderation_setting, :allow_nil => true, :prefix => :was
  # delegate :refuse_cause, :to => :moderation_setting, :allow_nil => true
  
  before_save :department_control
  
  belongs_to :user
  
  acts_as_commentable
  acts_as_voteable
  
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true
  # has_attached_file :picture, :styles => Proc.new { |clip| clip.instance.attachment_sizes }, :default_url => '/images/post_picture_missing.png'
  
  # validates_attachment_size :picture, :less_than => 2.megabytes
  # validates_attachment_content_type :picture, :content_type => [ /^image\/(?:jpeg|gif|png)$/, nil ]
  
  has_many :comments
  
  has_one :presentation_picture, :as => :presentation_picturable, :dependent => :destroy
  # accepts_nested_attributes_for :presentation_picture, :allow_destroy => true
  has_one :moderation_setting, :as => :moderatable, :dependent => :destroy
  # accepts_nested_attributes_for :moderation_setting, :allow_destroy => true
  
  has_many :categorizations, :as => :categorizable
  has_many :categories, :through => :categorizations
  accepts_nested_attributes_for :categories
  
  attr_accessible :presentation_picture_text, :department, :category_ids, :categories_attributes, :title, :description, :event_start_date, :event_end_date, :presentation_picture_id, :addr_street_1, :addr_street_2, :addr_postcode, :addr_city, :addr_country, :source_description, :source, :sources
  
  validates_uniqueness_of :title
  validates_presence_of :title, :description, :event_start_date, :category_ids
  validates_length_of :title, :maximum => 100
  validates_length_of :addr_street_1, :maximum => 100
  validates_length_of :addr_street_2, :maximum => 100
  validates_length_of :addr_city, :maximum => 50
  validates_length_of :addr_postcode, :maximum => 10
  validates_length_of :source_description, :maximum => 80
  validates_date :event_start_date, :format => "d/m/yyyy"
  validates_date :event_end_date, :on_or_after => :event_start_date, 
                                  :on_or_after_message => "La date de fin doit être similaire ou ultérieure à la date de début", 
                                  :allow_blank => true, :format => "dd/mm/yyyy"

  # validate :file_dimensions, :unless => "errors.any?"
  
  attr_accessor :source_description, :source, :presentation_picture_id
  
  def attachment_sizes
    if self.picture_orientation_horizontal
       size =  { :medium => "300x", :thumb => "50x50>" }
    else
       size =  { :medium => "200x", :thumb => "50x50>" }
    end
    size
  end
  
  private
  
  def department_control
    if self.addr_country != "France" && self.addr_country != "France, Metropolitan"
      self.department = ''
      puts 'Ho hooo'
    end
  end
  
  def file_dimensions
    if (picture.to_s <=> "post_picture_missing.png") == 1
      dimensions = Paperclip::Geometry.from_file(picture.to_file(:original))
      self.picture_width = dimensions.width
      self.picture_height = dimensions.height
      
      if (self.picture_height / self.picture_width) == 1
        self.picture_orientation_horizontal = false
      else
        self.picture_orientation_horizontal = true
      end
      
      if dimensions.width < 300 && dimensions.height < 300
        self.has_big_picture = false
      else
        self.has_big_picture = true
      end
    end
  end
end
