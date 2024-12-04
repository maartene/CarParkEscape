# Pomodoro Technique - 📝 Notes from the journey 🍅 by 🍅

## 🏷️ Labels

- ✅ done
- 🚧 WIP
- ❌ ERROR
- ⚠️ TODO

## 🍅 Pomodoro 1

🚧: Implement a car park with multiple levels and multiple stops

Cases:
✅ On what floor are we?
✅ In which spot are we?
✅ How many spots are on a floor? How many steps to take
✅ Where is the staircase? Left or right?
✅ Go down the stairs
✅ Are we on the ground floor?
✅ Go to the exit

⚠️ What if the start floor is not the latest element in the array?
⚠️ What if we don't need to go anyway --> Empty array

How did this feel?

- Tiring
- Fingers crossed
- Refactor during implementation
- Unclear what we were working on or trying to solve
- Feels unsafe
- Difficult to understand the output, need to debug
- Difficult to refactor, unclear what breaks
- We loose oversight of the code, run in to a lot of WTF
- Unclear what cases we implemented
- We ended up adding more testcases
- Naming of the test cases was difficult
- Difficult to help as navigator
- Steps too big
- Way of programming that feels: I don't want to make this my carreer
- Mental model in your head needs to be way too big
- Lack of a _shared_ mental model between driver and navigator

## Pomodoro 2: And now we do it the right way
- ✅ park right next to the exit
- ✅ park on the same floor (all the way to the left), a bit away from the exit
- ✅ park on the same floor (in the middle), a bit away from the exit
- ✅ park on a second floor right next to the stairs
- Fixed ❌ in test where parking on second floor, right next to stairs should return R3.

## Pomodoro 3: Continue with going left
- ✅ Need to move left two steps to reach the stairs
- ✅ Refactored tests to be parameterized
- ✅ Extract movement instruction from `escape` function

## Pomodoro 4: Three store garages
- ✅ Three store garages
- ✅ Refactor going down a stairs to also be an instruction

## Pomodoro 5: Three store garages
- ✅ Going down more than once
- ⚠️ Codewars test cases
- ⚠️ Instead of Directions being a string ("D", "L", "R") what if they are in domain language instead?
