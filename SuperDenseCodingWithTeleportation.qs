namespace SuperDenseCodingWithTeleportation {
    open Microsoft.Quantum.Convert;

    @EntryPoint()
    operation SuperDenseCodingWithTeleportation() : Int[] {
        // 0011 1010 0011 0011 is binary ASCII for :3
        let messages = [(false, false), (true, true), (true, false), (true, false),  // :
                        (false, false), (true, true), (false, false), (true, true)]; // 3

        mutable results = [];

        // Loop through all qubits
        for (b1, b2) in messages {
            // allocate 4 qubits
            // 2 for superdense coding and 2 for teleportation
            use (qAlice, qBob, qAliceTeleport, qBobTeleport) = (Qubit(), Qubit(), Qubit(), Qubit());
            
            // entangle qAlice with qBob
            Entangle(qAlice, qBob);

            // encode the message in qAlice
            Encode(qAlice, b1, b2);

            // teleport from qAliceTeleport to qBobTeleport with qAlice as the message
            Teleport(qAliceTeleport, qBobTeleport, qAlice);

            // decode the message from qBobTeleport and qBob
            let (b1, b2) = Decode(qBobTeleport, qBob);

            // collecting the results
            set results += [b1 ? 1 | 0];
            set results += [b2 ? 1 | 0];
            
            // reset all qubits back to |0〉
            Reset(qAlice);
            Reset(qBob);
            Reset(qAliceTeleport);
            Reset(qBobTeleport);
        }
        return results;
    }

    operation Encode(qAlice : Qubit, b1 : Bool, b2 : Bool) : Unit {
        if b1 {
            Z(qAlice);
        }
        if b2 {
            X(qAlice);
        }
    }

    operation Teleport(qAlice : Qubit, qBob : Qubit, qMessage : Qubit) : Unit {
        Entangle(qAlice, qBob);
        let (b1, b2) = SendMessage(qAlice, qMessage);
        ReciveMessage(qBob, b1, b2);
    }

    operation SendMessage(qAlice : Qubit, qMessage : Qubit) : (Bool, Bool) {
        CNOT(qMessage, qAlice);
        H(qMessage);
        return (ResultAsBool(M(qAlice)), ResultAsBool(M(qMessage)));
    }

    operation ReciveMessage(qBob : Qubit, b1 : Bool, b2 : Bool) : Unit {
        if b1 {
            X(qBob);
        }
        if b2 {
            Z(qBob);
        }
    }

    operation Decode(qMessage : Qubit, qBob : Qubit) : (Bool, Bool) {
        CNOT(qMessage, qBob);
        H(qMessage);
        return (ResultAsBool(M(qMessage)), ResultAsBool(M(qBob)));
    }

    operation Entangle(q1 : Qubit, q2 : Qubit) : Unit {
        H(q1);
        CNOT(q1, q2);
    }
}