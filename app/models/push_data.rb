class PushData < BinData::Record
  string :content, :read_length => :len
  uint32be :len, :value => lambda { content.bytesize}
end
