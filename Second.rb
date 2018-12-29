
use_bpm 120

live_loop :a do
  
  use_random_seed 23377
  
  p = (ring 0.5, 0.25).pick(16)
  s = scale(:e4, :minor).pick(8)
  
  with_synth :subpulse do
    play s.tick, release: 0.2, amp: 1.4
    sleep p.tick
  end
end

live_loop :drums, sync: :a do
  sample :drum_cymbal_pedal, amp: 1.2
  2.times do
    #sample :drum_cymbal_closed, amp: 0.9
    sleep 0.5
    #sample :drum_bass_hard, amp: 1.5
    sleep 0.5
  end
end

live_loop :sn, sync: :a do
  with_synth :dsaw do
    with_fx :rlpf do
      with_fx :reverb, room: 1 do
        a = play chord(:e1, :min).pick(1), release: 16, amp: 0.2, note_slide: 8
        control a, note: chord(:e4, :min).pick(1)
        sleep 8
      end
    end
  end
end
