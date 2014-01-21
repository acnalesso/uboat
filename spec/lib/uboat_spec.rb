require 'uboat'
require 'socket'

describe UBoat do

  it "kills a process running on a port" do
    p = fork { TCPServer.new(21779).accept }
    expect { Process.getpgid(p) }.not_to raise_error
    UBoat.kill(21779)
    expect { Process.getpgid(p) }.to raise_error(Errno::ESRCH)
  end

  it "returns the list of killed process ids" do
    p = fork { TCPServer.new(21779).accept }
    expect(UBoat.kill(21779)).to eq([p])
  end

  it "does not fail when port is not listened to" do
    expect { UBoat.kill(-1) }.not_to raise_error
  end

  it "returns empty array when port is not listened to" do
    expect(UBoat.kill(-1)).to eq([])
  end

end
