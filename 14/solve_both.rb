#!/usr/bin/env ruby
lines = File.readlines(ARGV[0]).map(&:strip)
total_seconds = 2503

# Base class for reindeers
class Reindeer
  attr_reader :distance
  attr_accessor :points

  def initialize(line)
    matches = line.match(/(\w+) can fly (\d+) .*for (\d+) .*for (\d+)/)
    @name = matches[1]
    @speed = matches[2].to_i
    @max_running_time = matches[3].to_i
    @resting_time = matches[4].to_i
    @running = true
    @time_counter = 0
    @distance = 0
    @points = 0
  end

  def next_sec
    @time_counter += 1
    if @running
      run
    else
      rest
    end
  end

  private

  def run
    @distance += @speed
    return if @time_counter != @max_running_time
    @running = false
    @time_counter = 0
  end

  def rest
    return if @time_counter != @resting_time
    @running = true
    @time_counter = 0
  end
end

reindeers = lines.map { |line| Reindeer.new(line) }

total_seconds.times do
  reindeers.each(&:next_sec)
  leader = reindeers.sort_by(&:distance).last.distance
  reindeers.select { |r| r.distance == leader }.each { |r| r.points += 1 }
end

p reindeers.sort_by(&:distance).last.distance
p reindeers.sort_by(&:points).last.points
