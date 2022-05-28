import Foundation

public typealias PitchSet = BitSetAdapter<Pitch, BitSet128>

extension PitchSet {
    public func chord(in key: Key) -> Chord? {
        var notes = NoteSet()
        forEach { notes.add($0.note(in: key))}
        return Chord(noteSet: notes)
    }
}

/// Essentially a midi note number.
///
/// We want to use a notion of pitch that lends itself to combinatorial algorithms,
/// as opposed to using e.g. a fundamental frequency.
public struct Pitch: Equatable, Hashable {

    var midiNoteNumber: Int8

    public init(_ midiNoteNumber: Int8) {
        self.midiNoteNumber = midiNoteNumber
    }

    /// If we have a Key, we can turn a Pitch into a Note.
    func note(in key: Key) -> Note {
        Note(pitch: self, key: key)
    }

    /// Returns the distance between Pitches in semitones.
    func semitones(to: Pitch) -> Int8 {
        abs(midiNoteNumber - to.midiNoteNumber)
    }

    /// Equivalence classes of pitches modulo octave.
    var pitchClass: Int8 {
        midiNoteNumber % 12
    }
}

extension Pitch: IntRepresentable {

    public var intValue: Int {
        Int(midiNoteNumber)
    }

    public init(intValue: Int) {
        self.midiNoteNumber = Int8(intValue)
    }

}

