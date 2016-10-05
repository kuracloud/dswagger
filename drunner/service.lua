-- drunner service configuration for minimalexample

function drunner_setup()
addconfig("PORT","The port to run Swagger on","80","port",true,true)
end

-- everything past here are functions that can be run from the commandline,
-- e.g. minimalexample help
containername = "drunner-${SERVICENAME}-dswagger"

function start()
   print(dsub("Launching Swagger on port ${PORT}"))

   if (drunning(containername)) then
      print("Swagger is already running.")
   else
      result=drun("docker", "run", "-d",
      "-p", "${PORT}:80",
      "-p", "${PORT}:80/udp",
      "--restart=always",
      "--name", containername,
      "${IMAGENAME}")

      if result~=0 then
        print("Failed to start Swagger.")
      end
   end
end

function stop()
  dstop(containername)
end

function info()
   if (drunning(containername)) then
      print(dsub("Swagger is running on port ${PORT}."))
   else
      print("Swagger is not currently running.")
   end
end

function help()
   return [[
   NAME
      ${SERVICENAME} - Runs Swagger
   SYNOPSIS
      ${SERVICENAME} start  - Launch Swagger
      ${SERVICENAME} stop   - Stop Swagger
      ${SERVICENAME} info   - Check status
   ]]
end
