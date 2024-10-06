<?php include 'bootstrap/index.php' ?>
<?php
$id = $_GET['id'];

$request = $db
  ->from(["tblrequest" => "requests"])
  ->where('id', $id)
  ->first()
  ->exec();

$captain = $db
  ->from(["tblofficials" => "officials"])
  ->join(["tblposition" => "positions"], "positions.id", "officials.position")
  ->where("positions.position", "Barangay Captain")
  ->first()
  ->select([
    "name" => "officials.name",
  ])
  ->exec();

if (isset($_GET['request_id'])) {
  $cr_request = $db
    ->from(["certificate_requests" => "cr"])
    ->join("residents", "residents.id", "cr.resident_id")
    ->where("cr.id", $_GET['request_id'])
    ->first()
    ->select([
      "data" => "cr.data",
      "firstname" => "residents.firstname",
      "middlename" => "residents.middlename",
      "lastname" => "residents.lastname",
      "created_at" => "residents.created_at",
    ])
    ->exec();

  if (!empty($cr_request)) {
    $cr_request['data'] = json_decode($cr_request['data'], true);

    $request['name'] = fullname($cr_request);
    $request['pcs'] = $cr_request['data']['quantity'];
    $request['type'] = $cr_request['data']['material'];
    $request['location'] = $cr_request['data']['location'];
    $request['applied'] = $cr_request['created_at'];
  }
}

?>
<!DOCTYPE html>
<html lang="en">

  <head>
    <?php include 'templates/header.php' ?>
    <title>Cutting Permit</title>
    <style>
    @page {
      size: auto;
      /* auto is the initial value */

      /* this affects the margin in the printer settings */
      margin: 18mm 18mm 18mm 18mm;
    }
    .certification-title {
      font-family: cooper black;
      font-size: 30px;
      color: black;
    }
    </style>
  </head>

  <body>
    <?php include 'templates/loading_screen.php' ?>
    <div class="wrapper">
      <!-- Main Header -->
      <?php include 'templates/main-header.php' ?>
      <!-- End Main Header -->

      <!-- Sidebar -->
      <?php include 'templates/sidebar.php' ?>
      <!-- End Sidebar -->

      <div class="main-panel">
        <div class="content">
          <div class="panel-header bg-primary-gradient">
            <div class="page-inner">
              <div class="d-flex align-items-left align-items-md-center flex-column flex-md-row">
                <div>
                  <h2 class="text-white fw-bold">Generate Permit</h2>
                </div>
              </div>
            </div>
          </div>
          <div class="page-inner">
            <div class="row mt--2">
              <div class="col-md-12">

                <?php include "templates/alert.php"; ?>

                <div class="card">
                  <div class="card-header">
                    <div class="card-head-row">
                      <div class="card-title">Cutting Permit</div>
                      <div class="card-tools">
                        <button class="btn btn-info btn-border btn-round btn-sm" onclick="printDiv('printThis')">
                          <i class="fa fa-print"></i>
                          Print Certificate
                        </button>
                      </div>
                    </div>
                  </div>

                  <div class="card-body m-5" id="printThis">
                    <div class="d-flex flex-wrap justify-content-around">
                      <div class="text-center">
                        <img src="assets/uploads/<?= $brgy_logo ?>" class="img-fluid" width="100">
                      </div>
                      <div class="text-center">
                        <h3 class="fw-bold mb-0" style="font-size: 15px; font-family: Times New Roman;">Republic of the Philippines</h3>
                        <h3 class="fw-bold mb-0" style="font-size: 15px; font-family: Times New Roman;">Province of <?= ucwords($province) ?></h3>
                        <h3 class="fw-bold mb-0" style="font-size: 15px; font-family: Times New Roman;"><?= ucwords($town) ?></h3>
                        <h1 class="fw-bold mb-0" style="font-size: 18px; font-family: Times New Roman;"><?= ucwords($brgy) ?></h2>
                      </div>
                      <div class="text-center">
                        <img src="assets/uploads/<?= $city_logo ?>" class="img-fluid" width="100">
                      </div>
                    </div>
                        <div class="text-center">
                        <h2 class="mt-4 fw-bold" style="font-size: 20px;">OFFICE OF THE PUNONG BARANGAY</h2>
                        <h1 class="mt-4 fw-bold mb-5 certification-title"><u>C E R T I F I C A T I O N</u></h1>
                          
                        </div>
                        <h2 class="mt-5 fw-bold"style="font-size: 15px;">TO WHOM IT MAY CONCERN:</h2>
                        <h3 class="mt-3" style="text-indent: 40px; font-size: 15px;">This is to certify that <?= ucfirst($request['pcs']) ?> pcs <?= ucfirst($request['type']) ?>
                          , that grow in ______________________ on the Agricultural land and residential land of Mr./Mrs.______________________with a tax declaration No.________________, Lot No.______________ and Mr./Mrs._____________________
                          with a tax declaration No.____________________, Lot No._____________________ Located at <span class="fw-bold"
                            style="font-size:15px"><?= ucwords($brgy) ?>, <span class="fw-bold"
                              style="font-size:15px"><?= ucwords($town) ?>,. <span class="fw-bold"
                                style="font-size:15px"><?= ucwords($province) ?>.</span></span></span>
                        </h3>

                        <h3 class="mt-3" style="text-indent: 40px; font-size: 15px;">This Undersigned interpose no objection as to the cutting of the aformentioned tree provided that all laws, rules and regulation are duly complied. </h3>

                          <h3 class="mt-3" style="text-indent: 40px; font-size: 15px;">This CERTIFICATION is issued upon the request of the above mentioned name for whatever legal intents it may serve.

                          </h3>
                        <h3 class="mt-3" style="text-indent: 40px; font-size: 15px;"> Issued this <?= ucfirst($request['applied']) ?> at the Office of the Punong Barangay,
                        <span class="fw-bold"> Suso</span>, <span class="fw-bold"
                              style="font-size:18px"><?= ucwords($town) ?>, <span class="fw-bold"
                                style="font-size:18px"><?= ucwords($province) ?>.</span></span></span>
                        </h3>
                        <br>


                                  <div class="col-md-12">
                                  <div class="p-3 text-right mr-5">
                                    <h1 class="fw-bold mb-0 text-uppercase" style="text-align: right; font-size: 16px"><u><?= ucwords($captain['name']) ?></u></h1>
                                    <p class="mr-5" style="text-align: right; font-size: 13px;">PUNONG BARANGAY</p>
                                    <p style="font-family: cooper black; font-size: 15px;"><b>Not valid without official seal</b></p>
                                  </div>
                        
                      <div class="col-md-12 d-flex flex-wrap left-content">
                        <div class="p-3 text-center">
                        </div>
                      </div>
                            </form>
                          </div>
                      </div>
                    </div>

                    <!-- Main Footer -->
                    <?php include 'templates/main-footer.php' ?>
                    <!-- End Main Footer -->
                  </div>

                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>


    <!-- Modal -->
    <div class="modal fade" id="pment" data-backdrop="static" data-keyboard="false">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Create
              Payment</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form method="POST" action="model/save_pment.php">
              <div class="form-group">
                <label>Amount</label>
                <input type="number" class="form-control" name="amount" placeholder="Enter amount to pay" required>
              </div>

              <div class="form-group">
                <label>Date Issued</label>
                <input type="date" class="form-control" name="date" value="<?= date("Y-m-d") ?>">
              </div>

              <div class="form-group">
                <label>Mode</label>
                <select class="form-control" name="mode" required>
                  <option selected disabled>Choose payment mode</option>
                  
                  <option value="cash">Cash</option>
                </select>
              </div>

              <div class="form-group">
                <label>Payment Details(Optional)</label>
                <textarea class="form-control" placeholder="Enter Payment Details"
                  name="details">Cutting Permit Payment</textarea>
              </div>
          </div>
          <div class="modal-footer">
            <input type="hidden" name="resident_id" value="<?= $_GET['id'] ?>">
            <input type="hidden" name="create-payment" value="<?= $_GET['id'] ?>">
            <input type="hidden" name="request_id" value="<?= getBody('request_id', $_GET) ?>">
            <input type="hidden" name="certificate_id" value="6">
            <button type="button" class="btn btn-secondary" onclick="goBack()">Close</button>
            <button type="submit" class="btn btn-primary">Save</button>
          </div>
          </form>
        </div>
      </div>
    </div>

    <?php include 'templates/footer.php' ?>

    <script>
    const urlSearchParams = new URLSearchParams(window.location.search);
    const params = Object.fromEntries(urlSearchParams.entries());

    if (!params['closeModal']) {
      setTimeout(() => {
        $('#pment').modal('show');
      }, 1000);
    }

    function printDiv(divName) {
      var printContents = document.getElementById(divName).innerHTML;
      var originalContents = document.body.innerHTML;

      document.body.innerHTML = printContents;

      window.print();

      document.body.innerHTML = originalContents;
    }
    </script>
  </body>

</html>
