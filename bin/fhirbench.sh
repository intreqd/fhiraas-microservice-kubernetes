# this is hostile software
# fhiraas, 2020-2022, Ron Sweeney Integration Required, LLC and DIMSE Cloud 
# set these in environment
# FHIRAPI=itbn1z8j2b.execute-api.us-east-2.amazonaws.com/fhir
# NUMUSERS=500
# yes, those ^^^, or dont and use the below
set -m # Enable Job Control
rm status.out
export TERM=xterm
export FHIRAPI="127.0.0.1:30036"
export NUMUSERS=2
START="$(date +%s)"
generate_post_data()
{
  GAR=`openssl rand -base64 12 | tr -d '[:digit:]'`
  BLEH=`openssl rand -base64 12 | tr -dd '[:digit:]'`
  cat <<EOF
{
      "name": [
        {
          "use": "official",
          "family": "$BLEH",
          "given": [
            "$GAR"
          ]
        }
      ],
      "gender": "female",
      "birthDate": "1970-01-01",
      "resourceType": "Patient"
    }
EOF
}

# Lets load a bunch of patients.
echo "PUTS..."
for i in `seq $NUMUSERS`; do
   sleep .015
   #echo "PUT: $i"
   GAR=`openssl rand -base64 12`
   curl -s -o /dev/null -w "%{http_code}\n" -X POST \
    -H "Content-Type: application/fhir+json; charset=utf-8" \
    --data "$(generate_post_data)" \
   "http://$FHIRAPI/Patient" >> status.out &

done
while [ 1 ]; do fg 2> /dev/null; [ $? == 1 ] && break; done

# Search for a bunch of patients (should test caching)
# Rather JUST Get for now to guage reachability
echo "GETS..."
for i in `seq $NUMUSERS`; do # start jobs in parallel
  sleep .015
  curl -s -o /dev/null -w "%{http_code}\n" -X GET "http://$FHIRAPI/Patient" -H  "accept: */*" >> status.out &
done

while [ 1 ]; do fg 2> /dev/null; [ $? == 1 ] && break; done
echo ""
echo ""
echo "InterSystems FHIR Accelerator Service Benchmark for $NUMUSERS concurrent clients."
cat status.out | sort |uniq -c | sort -nr
DURATION=$[ $(date +%s) - ${START} ]
echo "Took:" ${DURATION} " seconds"

generate_post_data()
{
  GAR=`openssl rand -base64 12 | tr -d '[:digit:]'`
  BLEH=`openssl rand -base64 12 | tr -dd '[:digit:]'`
  cat <<EOF
{
      "name": [
        {
          "use": "official",
          "family": "$BLEH",
          "given": [
            "$GAR"
          ]
        }
      ],
      "gender": "female",
      "birthDate": "1970-01-01",
      "resourceType": "Patient"
    }
EOF
}