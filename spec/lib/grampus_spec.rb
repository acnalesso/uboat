require 'grampus'
require 'socket'

describe Grampus do

  before do
    `lsof -t -i tcp:21779 | xargs kill`
  end

  it "kills a process running on a port" do
    p = fork { TCPServer.new(21779).accept }
    expect { Process.getpgid(p) }.not_to raise_error
    Grampus.kill(21779)
    expect { Process.getpgid(p) }.to raise_error(Errno::ESRCH)
  end

  it "returns the list of killed process ids" do
    p = fork { TCPServer.new(21779).accept }
    expect(Grampus.kill(21779)).to eq([p])
  end

  it "does not fail when port is not listened to" do
    expect { Grampus.kill(-1) }.not_to raise_error
  end

  it "returns empty array when port is not listened to" do
    expect(Grampus.kill(-1)).to eq([])
  end

end
