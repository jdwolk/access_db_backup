require 'fileutils'

class Archiver < Struct.new(:dest_dir, :src_file)
  def archive!
    puts "Creating DB backup in #{dest_file}"
    FileUtils.cp src_file, dest_file
  end

  private

  def dest_file
    src_filename = make_filename(File.basename(src_file))
    File.join(dest_dir, src_filename)
  end

  def make_filename(orig_file)
    ext = File.extname(orig_file)
    filename = File.basename(orig_file, ext)
    "#{filename}__#{Time.now.strftime('%Y_%m_%d-%H_%M_%S')}#{ext}"
  end
end

# TODO: Dummy hardcoded paths - change in real usage
dest_dir = '/path/to/dest/dir'
backend_file = '/path/to/db_be.accdb'
frontend_file = '/path/to/db_fe.accdb'

be_archiver = Archiver.new(dest_dir, backend_file)
fe_archiver = Archiver.new(dest_dir, frontend_file)
be_archiver.archive!
fe_archiver.archive!
