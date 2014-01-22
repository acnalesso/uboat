class UBoat

  def self.kill(port)
    new.kill_at(port)
  end

  def kill_at(port)
    pids = processes_at(port)
    puts "Processes at port #{port}: #{pids.empty? ? "none" : pids.join(", ")}"
    pids.each do |pid|
      puts "Killing process #{pid}"
      Process.kill("QUIT", pid)
    end
    pids.each do |pid|
      if alive?(pid)
      puts "Waiting for process #{pid} to quit"
      sleep 0.1 while alive?(pid)
      puts "Long live process #{pid}"
      end
    end
    pids
  end

  def processes_at(port)
    pids = `lsof -t -i tcp:#{port} 2>/dev/null`
    pids.empty? ? [] : pids.lines.map { |l| l.to_i }
  end

  def alive?(pid)
    Process.getpgid(pid) rescue false
  end
end
