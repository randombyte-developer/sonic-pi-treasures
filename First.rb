
live_loop :chs do
  c = (ring chord(:e3, :minor), chord(:a3, :minor), chord(:d3, :minor), chord(:g3, :major)).tick
  
  with_fx :reverb, room: 1 do
    with_synth :dsaw do
      with_fx :slicer do
        play c[0] - 12, release: 4, attack: 0.1, amp: 0.8
      end
    end
  end
  
  with_synth :tb303 do
    with_fx :reverb, room: 0.8 do
      8.times do
        play c, release: 0.3, amp: 0.5
        sleep 0.25
      end
    end
  end
end

live_loop :drums, sync: :chs do
  with_fx :reverb, room: 1 do
    sample :drum_cymbal_pedal
    2.times do
      sample :drum_cymbal_closed
      2.times do
        sleep 0.25
        sample :drum_heavy_kick, amp: 4
        sleep 0.25
      end
    end
  end
end