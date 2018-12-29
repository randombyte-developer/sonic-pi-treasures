use_bpm 130

live_loop :drums do
  with_fx :rlpf, cutoff: 67 do
    with_fx :reverb, room: 1 do
      with_fx :distortion, distort: 0.9 do
        7.times do
          sample :drum_heavy_kick
          sleep 1
        end
        sample :drum_heavy_kick
        sleep 0.75
        sample :drum_heavy_kick
        sleep 0.25
        
      end
    end
  end
end

live_loop :cym do
  if (spread 1, 32).tick(:a) then
    with_fx :rlpf, cutoff: 100 do
      with_fx :distortion do
        sample :drum_cymbal_open, amp: 0.6
      end
    end
  end
  if (spread 3,8).tick(:closed) then
    sample :drum_cymbal_closed
  end
  sleep 0.25
end

live_loop :dum do
  use_sample_defaults amp: 6
  
  with_fx :rlpf, cutoff: 70 do
    with_fx :reverb do
      with_fx :distortion, distort: 0.6 do
        sleep 4
        sleep 7.5
        sample :elec_mid_snare
        sleep 0.5
        sample :elec_mid_snare
      end
    end
  end
end

live_loop :synth, sync: :drums do
  cut = range(80, 90, 4).mirror
  rel = range(9, 14, 1).mirror
  
  use_synth :saw
  use_synth_defaults release: rel.tick
  with_fx :reverb, room: 0.8 do
    with_fx :rlpf, cutoff: cut.tick do
      with_fx :slicer, amp: 3, phase: 0.3, phase_slide: 5 do |slice|
        control slice, phase: 0.5
        play_pattern_timed [chord(:d3, :min, num_octaves: 2).choose,
                            chord(:a3, :min, num_octaves: 2).choose,
                            chord(:c3, :maj).choose,
                            chord(:f3, :maj).choose], [1, 0.75, 0.5, 0.5]
      end
    end
  end
  sleep 8
end

live_loop :noise, sync: :drums do
  n = range(90, 100, 0.2).mirror
  with_synth :pnoise do
    with_fx :rhpf, cutoff: n.tick(:noisecut) do
      play 1, release: 5, amp: 0.15
    end
  end
  
  sleep 0.25
end