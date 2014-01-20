class UBoat

  def self.kill(port)
    new.kill_at(port)
  end

  def kill_at(port)
    pids = processes_at(port)
    pids.each do |pid|
      Process.kill("QUIT", pid)
    end
    pids.each do |pid|
      sleep 0.01 while alive?(pid)
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
