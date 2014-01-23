require 'uboat'
require 'socket'

def create_server_process
  puts "Creating a process listening on port 21779"
  system <<-BASH
    nohup nc -l 21779 <<< 'hi' &>/dev/null &
    disown %%
  BASH
  p = `lsof -t -i:21779`.to_i
  puts "Done creating process #{p}"
  p
end

describe UBoat do

  it "kills a process running on a port" do
    p = create_server_process
    expect { Process.getpgid(p) }.not_to raise_error
    UBoat.kill(21779)
    expect { Process.getpgid(p) }.to raise_error(Errno::ESRCH)
  end

  it "returns the list of killed process ids" do
    p = create_server_process
    expect(UBoat.kill(21779)).to eq([p])
  end

  it "does not fail when port is not listened to" do
    expect { UBoat.kill(-1) }.not_to raise_error
  end

  it "returns empty array when port is not listened to" do
    expect(UBoat.kill(-1)).to eq([])
  end

end
