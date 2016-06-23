# Mime::Type.register "text/plain", :igs
 Paperclip.options[:content_type_mappings] = { igs: 'text/plain', dxf: 'text/plain'  }


# module Paperclip
#   class MediaTypeSpoofDetector
#     private

#     def type_from_file_command
#       # -- original code removed --
#       # begin
#       #   Paperclip.run("file", "-b --mime-type :file", :file => @file.path)
#       # rescue Cocaine::CommandLineError
#       #   ""
#       # end

#       # -- new code follows --
#       begin
#          Paperclip.run("file", "-b --mime :file", :file => @file.path)
#       rescue Cocaine::CommandLineError
#         ""
#       end
#     end
#   end
# end


 # module Paperclip
 #   class MediaTypeSpoofDetector
 #     def spoofed?
 #       false
 #     end
 #   end
 # end
# text_plain = MIME::Types["text/plain"].first
# text_plain.extensions << "igs"
# MIME::Types.index_extensions text_plain
