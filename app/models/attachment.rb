class Attachment < ActiveRecord::Base
	has_attached_file :document
end
