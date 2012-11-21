class PushData < BinData::Record
  uint32be :len, :value => lambda { content.bytesize}
  string :content, :read_length => :len
end
