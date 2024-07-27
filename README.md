# Superdense Coding With Teleportation
This Q# script encodes text into qubits, teleports them, and decodes the message. Saying it like this makes this project look way too good. 
This project exists only for me to be able to say that i teleported ":3".

To quickly show what the script does, let's look at a circuit representation.

![circuit of superdense coding with teleportation](readme-resources/SuperdenseCodingWithTeleportation.gif)\
[view online in quirk](https://algassert.com/quirk#circuit={"cols":[[1,1,"H"],[1,1,"•",1,1,1,"X"],["…","…","…","…","…","…","…"],["Counting2"],["Measure","Measure"],["~msg"],["Chance","Chance"],["~enc"],[1,"•","X"],["•",1,"Z"],[1,1,1,"~send"],[1,1,1,"H"],[1,1,1,"•",1,"X"],[1,1,"•","X"],[1,1,"H"],[1,1,"Measure","Measure"],[1,1,1,"•",1,"X"],[1,1,"•",1,1,"Z"],[1,1,1,1,1,"~dec"],[1,1,1,1,1,"•","X"],[1,1,1,1,1,"H"],[1,1,1,1,1,"Measure","Measure"],[1,1,1,1,1,"~msg"],[1,1,1,1,1,"Chance","Chance"]],"gates":[{"id":"~msg","name":"message","matrix":"{{1,0,0,0},{0,1,0,0},{0,0,1,0},{0,0,0,1}}"},{"id":"~enc","name":"encode","matrix":"{{1,0,0,0},{0,1,0,0},{0,0,1,0},{0,0,0,1}}"},{"id":"~send","name":"send","matrix":"{{1,0,0,0},{0,1,0,0},{0,0,1,0},{0,0,0,1}}"},{"id":"~dec","name":"decode","matrix":"{{1,0,0,0},{0,1,0,0},{0,0,1,0},{0,0,0,1}}"}]})

If you know a bit about quantum mechanics, this probably looks familiar.
Because this is superdense coding with teleportation instead of a switch gate.

For reference here is superdense coding:

![circuit of superdense coding](readme-resources/SuperdenseCoding.gif)

and here is teleportation:

![circuit of teleportation](readme-resources/Teleportation.gif)

## But what do i mean by teleported ":3"
So in essence what i am doning is superdense coding with extra steps. Superdense coding is transporting 2 regular bits with 1 qubit. 

At the entry point we have the following lines. 
```qsharp
// 0011 1010 0011 0011 is binary ASCII for :3
let messages = [(false, false), (true, true), (true, false), (true, false),  // :
                (false, false), (true, true), (false, false), (true, true)]; // 3
```
Here i create an array of tupels, each containing 2 booleans. This represents the bits to be teleported. Then the "Superdense Coding with Teleportation" operation is performed on each tuple in the array. The result is then aggregated and returned as integers. (because it looks nicer as an output)

## Results of a real run
I ran this script on Quantinnum's [H1 quantum computer](https://www.quantinuum.com/hardware/h1) via Azure Quantum for 10 shots. This consumed 7.11 Azure Quantum credits which would be 89$.

Here is the histogram output.
```json
{
    "Histogram":
    [
        "[0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1]",0.8,
        "[0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1]",0.1,
        "[0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1]",0.1
    ]
}
```
We can see that out of 10 shots 8 where without error. So i teleported ":3" 8 times tehe >:3. 