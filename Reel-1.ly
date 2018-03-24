\version "2.18.2"
\language "italiano"

\header {
  title = "Reel 1"
  % Elimina la tagline predefinita di LilyPond
  tagline = ##f
}

\paper {
  #(set-paper-size "a4")
}

\layout {
  \context {
    \Voice
    \consists "Melody_engraver"
    \override Stem #'neutral-direction = #'()
  }
}

global = {
  \key la \minor
  \time 4/4
  \tempo 4=100
}

right = \relative do'' {
  \global
  \repeat volta 2 {la8 do, mi la do, mi la fa | sol do, mi sol do, mi la sol |
  la do, fa la do, fa la mi | sol do, mi sol do, mi sol la }
  \repeat volta 2 {do,4 fa8 mi4 fa8 sol la | mi4 sol8 la4 la8 sol fa |
  la4  re,8 do4 re8 mi fa | mi4 sol8 la4 la8 sol fa }
  
  la8 do4 do8 re4 do8 mi8~ mi8 sol8 fa mi  
  re8 do8 si8 la
  la4 do, mi la \bar "|."

}

left = \relative do' {
  \global
  \repeat volta 2 {<la, mi'>1 | <do sol'> | <la mi'>1 | <do sol'> }
  \repeat volta 2 {la8 do mi la, do mi la, mi' | do mi sol do, mi sol do, sol'
  la,8 do mi la, do mi la, mi' | do mi sol do, mi sol do, sol'}

  la,8 do mi la, do mi la, mi' | do mi sol do, mi sol do, sol'|
  %la,4 do mi la, |
  la4 mi do la
}

bass = \relative do, {
  \global
  \repeat volta 2 {la4. la4. r8 do8 | do4. do4. r8 la8 | la4. la4. r8 do8 | do4. do4. r8 la8 }
  \repeat volta 2 {la4 la8 do4 mi8 re do | do4 do8 mi4 sol8 fa mi | la,4 la8 do4 mi8 re do | 
                   do4 do8 mi4 sol8 fa mi }

  la,4 la8 do4 mi8 re do | do4 do8 mi4 sol8 fa mi |
  la,4 la8 do4 do8 si la
}

bodhran = \drummode {
  \repeat volta 2 {bol4 bolo8 bol4. bol4 | bol4 bolo8 bol4. bol4 | bol4 bolo8 bol4. bol4 | bol4 bolo8 bol4. bol4}
  \repeat volta 2 {bol4 bolo8 bol4. bol4 | bol4 bolo8 bol4. bol4 | bol4 bolo8 bol4. bol4 | bol4 bolo8 bol4. bol4 }
  
  | bol4 bolo8 bol4. bol4 | bol4 bolo8 bol4. bol4
  bol4 bolo8 bol4. bol4
}

pianoPart = \new PianoStaff \with {
  instrumentName = "Pf."
  shortInstrumentName = "Pf."
} <<
  \new Staff = "right" \with {
   midiInstrument = "acoustic grand"
  } \right
  \new Staff = "left" \with {
    midiInstrument = "acoustic grand"
  } { \clef bass \left }
>>

bassPart = \new StaffGroup \with {
  \consists "Instrument_name_engraver"
  instrumentName = "B."
  shortInstrumentName = "B."
} <<
  \new Staff \with {
    midiInstrument = "acoustic bass"
  } { \clef "bass_8" \bass }
  
>>

bodhranPart = \new DrumStaff \with {
  instrumentName = "Bd."
  shortInstrumentName = "Bd."
  midiInstrument = "taiko drum"
  
%  drumStyleTable = #(alist->hash-table percussion-style)
} <<
  \new DrumVoice
  {
    \set DrumStaff.drumStyleTable =#percussion-style
   \bodhran
  }

>>

\score {
  <<
   \pianoPart
   \bassPart
   \bodhranPart
  >>
  \layout { }
}

\score {
   <<
   \unfoldRepeats \pianoPart
   \unfoldRepeats \bassPart
   \unfoldRepeats \bodhranPart
  >>
  \midi { }
}

