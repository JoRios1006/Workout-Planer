import REPL
using REPL.TerminalMenus
using Match


# TODO: add a way to save the items to a file
# TODO: add a way to load the items from a file
const options = ["ADD", "REMOVE", "EDIT", "CALC_RM", "SEE", "SAVE", "LOAD","ADD_TODAY_WORKOUT" , "SEE_TODAY_WORKOUT", "EXIT"]
const menu = RadioMenu(options, pagesize=length(options) )

struct Workout
    Exercise::Symbol
    Muscle_Group::Symbol
end

#initialize items with 10 examples
items::Vector{Workout} = []


struct TodayWorkout
    Exercise::Symbol
    Muscle_Group::Symbol
    Reps::Int64
    Weight::Float64
end

#initialize items with 10 examples
today_items::Vector{TodayWorkout} = []


function add_today_workout()
    run(`clear`)
    println("Exercise:")
    Exercise = readline() |> Symbol
    println("Muscle Group:")
    Muscle_Group = readline() |> Symbol
    println("Reps:")
    Reps = readline() |> x -> parse(Int64, x)
    println("Weight:")
    Weight = readline() |> x -> parse(Float64, x)
    run(`clear`)
    println("DONE!")
    println("ADDED:", "  " ,Exercise, "  ", Muscle_Group, "  ", Reps, "  ", Weight)
    readline()
    run(`clear`)
    TodayWorkout(Exercise, Muscle_Group, Reps, Weight) |> x -> push!(today_items, x)
end


# File Format for the save and load functions
# org-mode style
# #+TITLE: Workouts
# ## Chest
# - Bench Press
# - Dumbbell Fly
# ## Back
# ...

function underscore_to_space(s::String)
    return replace(s, "_" => " ")
end

# TODO: Group by muscle group
function save()
    run(`clear`)
    println("File Name:")
    file_name = readline()
    run(`clear`)
    println("DONE!")
    println("SAVED:", "  " ,file_name)
    readline()
    run(`clear`)
    open(file_name, "w") do io
        println(io, "#+TITLE: Workouts")
        for i in items
            println(io, "## ", underscore_to_space(string(getproperty(i, :Muscle_Group))))
            println(io, "- ", underscore_to_space(string(getproperty(i, :Exercise))))
        end
    end
end

# TODO: fix the bug LoadError: UndefVarError: muscle_group not defined
function load()
    run(`clear`)
    println("File Name:")
    file_name = readline()
    run(`clear`)
    println("DONE!")
    println("LOADED:", "  " ,file_name)
    readline()
    run(`clear`)
    open(file_name, "r") do io
        for line in eachline(io)
            if line[1] == '#'
                muscle_group = line[4:end]
            elseif line[1] == '-'
                exercise = line[3:end]
                Workout(exercise, muscle_group) |> x -> push!(items, x)
            end
        end
    end
end

function addF()
    run(`clear`)
    println("Exercise:")
    Exercise = readline() |> Symbol
    println("Muscle Group:")
    Muscle_Group = readline() |> Symbol
    run(`clear`)
    println("DONE!")
    println("ADDED:", "  " ,Exercise, "  ", Muscle_Group)
    readline()
    run(`clear`)
    Workout(Exercise, Muscle_Group) |> x -> push!(items, x)
end

function removeF()
    run(`clear`)
    println("Exercise:")
    Exercise = readline() |> Symbol
    println("Muscle Group:")
    Muscle_Group = readline() |> Symbol
    run(`clear`)
    println("DONE!")
    println("REMOVED:", "  " ,Exercise, "  ", Muscle_Group)
    readline()
    run(`clear`)
    Workout(Exercise, Muscle_Group) |> x -> deleteat!(items, findfirst(isequal(x), items))
end

function edit()
    run(`clear`)
    println("Exercise:")
    Exercise = readline() |> Symbol
    println("Muscle Group:")
    Muscle_Group = readline() |> Symbol
    run(`clear`)
    println("DONE!")
    println("EDITED:", "  " ,Exercise, "  ", Muscle_Group)
    readline()
    run(`clear`)
    Workout(Exercise, Muscle_Group) |> x -> deleteat!(items, findfirst(isequal(x), items))
    println("Exercise:")
    Exercise = readline() |> Symbol
    println("Muscle Group:")
    Muscle_Group = readline() |> Symbol
    run(`clear`)
    println("DONE!")
    println("ADDED:", "  " ,Exercise, "  ", Muscle_Group)
    readline()
    run(`clear`)
    Workout(Exercise, Muscle_Group) |> x -> push!(items, x)
end

# https://www.bodybuilding.com/content/how-to-calculate-1-rep-max.html
function calc_rm()
    run(`clear`)
    println("Weight:")
    Weight = readline() |> x -> parse(Float64, x)
    println("Reps:")
    Reps = readline() |> x -> parse(Int64, x)
    run(`clear`)
    println("DONE!")
    println("RM:", "  " ,Weight*Reps*0.033+Weight)
    readline()
    run(`clear`)
end

    stringHelperFunction(items::Vector{Workout}) = maximum([length(string(getproperty(i, :Exercise))) for i in items])
function prettyPrint(items::Vector{Workout})
    run(`clear`)
    println("Exercise", " "^(stringHelperFunction(items)-length("Exercise")), "Muscle Group")
    for i in items
        println(getproperty(i, :Exercise), " "^(stringHelperFunction(items)-length(string(getproperty(i, :Exercise)))), getproperty(i, :Muscle_Group))
    end
    readline()
    run(`clear`)
end

while true
    choice = request("CHOOSE", menu)
    @match choice begin
        1 => addF()
        2 => removeF()
        3 => edit()
        4 => calc_rm()
        5 => prettyPrint(items)
        6 => save()
        7 => load()
        8 => add_today_workout()
        9 => prettyPrint(today_items)
        10 => break
        _ => println("ERROR")
    end

end


# Path: main.jl
