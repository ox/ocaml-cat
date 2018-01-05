open Core.Std
open Command.Let_syntax

let printFile (filePath) =
  match Sys.file_exists_exn filePath with
    | true ->
        In_channel.with_file filePath ~f:(fun file ->
          In_channel.iter_lines file print_endline
        )
    | false -> Printf.printf "%s does not exist" filePath
;;

let () =
  Command.basic'
    ~summary:"A unix cat clone"
    [%map_open
      let filename = anon ("<file>" %: string) in
      fun () -> printFile filename;
    ]
  |> Command.run ~version:"1.0" ~build_info:"RWO";;
