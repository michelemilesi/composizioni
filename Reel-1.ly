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
  la8 do, mi la do, mi la fa | sol do, mi sol do, mi la sol | 
  la do, fa la do, fa la mi | sol do, mi sol do, mi sol la \bar "||"
  mi4 fa8 sol4 la8 fa do
  
}

left = \relative do' {
  \global
  <la, mi'>1 | <do sol'> | <la mi'>1 | <do sol'> \bar "||"
  la8 do mi la, do mi la, mi' | do mi sol do, mi sol do, sol'
  
}

bass = \relative do, {
  \global
  la4. la4. r8 do8 | do4. do4. r8 la8 | la4. la4. r8 do8 | do4. do4. r8 la8 \bar "||"
  la4 la8 do4 mi8 do la
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
  \new TabStaff \with {
    stringTunings = #bass-tuning
  } \bass
>>

\score {
  <<
    \pianoPart
    \bassPart
  >>
  \layout { }
  \midi { }
}
