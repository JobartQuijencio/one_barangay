<?php include 'bootstrap/index.php' ?>
<?php

global $db;

$id = $_GET['id'];

$permit = $db
  ->from(["tblpermit" => "permit"])
  ->where('permit.id', $id)
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
  $request = $db
    ->from(["certificate_requests" => "cr"])
    ->where("cr.id", $_GET['request_id'])
    ->first()
    ->exec();

  if (!empty($request)) {
    $request['data'] = json_decode($request['data'], true);

    $permit['name'] = $request['data']['name'];
    $permit['owner1'] = $request['data']['owner_1'];
    $permit['owner2'] = $request['data']['owner_2'];
    $permit['nature'] = $request['data']['nature'];
    $permit['applied'] = $request['created_at'];
  }
}


?>
<!DOCTYPE html>
<html lang="en">

  <head>
    <?php include 'templates/header.php' ?>
    <title>Business Permit</title>
    <style>
    @page {
      size: auto;
      /* auto is the initial value */

      /* this affects the margin in the printer settings */
      margin: 20mm 20mm 20mm 20mm;
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
                      <div class="card-title">Barangay Business Permit</div>
                      <div class="card-tools">
                        <button class="btn btn-info btn-border btn-round btn-sm" onclick="printDiv('printThis')">
                          <i class="fa fa-print"></i>
                          Print Certificate
                        </button>
                      </div>
                    </div>
                  </div>
                  <div class="card-body m-5" id="printThis">
                    <div class="d-flex flex-wrap justify-content-around" style="border-bottom:1px solid black">
                      <div class="text-center">
                        <img src="assets/uploads/<?= $brgy_logo ?>" class="img-fluid" width="100">
                      </div>
                      <div class="text-center">
                                            <h3 class="fw-bold mb-0" style="font-size: 15px; font-family: Times New Roman;">Republic of the Philippines</h3>
                                            <h3 class="fw-bold mb-0" style="font-size: 15px; font-family: Times New Roman;">Province of <?= ucwords($province) ?></h3>
                                            <h3 class="fw-bold mb-0" style="font-size: 15px; font-family: Times New Roman;"><?= ucwords($town) ?></h3>
                                            <h3 class="fw-bold mb-0" style="font-size: 18px; font-family: Times New Roman;"><?= ucwords($brgy) ?></h3><br>
                                        </div>
                      <div class="text-center">
                        <img src="assets/uploads/<?= $city_logo ?>" class="img-fluid" width="100">
                      </div>
                    </div>
                    <div class="row mt-2">
                      <div class="col-md-12">
                        <div class="text-center mt-5">
                          <h1 class="mt-4 fw-bold" style="font-size: 20px;">OFFICE OF THE PUNONG BARANGAY</h1>
                        </div>
                        <div class="text-center">
                          <h1 class="mt-4 fw-bold mb-5" style="font-family: cooper; font-size:25px;color: black"><u>B U S I N E S S C L E A R A N C E</u></h1>
                        </div>
                        <h2 class="mt-5 fw-bold" style="font-size: 15px;">GRANTED TO:</h2>
                        <div class="text-center pt-4">
                          <h1 class="mt-3 fw-bold mb-0"><?= ucfirst($permit['name']) ?></h1>
                          <hr class="w-50 mt-0 mb-0 mx-auto" style="border-top: 2px solid black;">
                          <h2 class="mt-0" style="font-size: 15px;">NAME OF BUSINESS OWNER</h2>
                        </div>
                        <div class="text-center pt-4 mb-5">
                          <h1 class="mt-3 fw-bold mb-0">
                            <?= empty($permit['owner2']) ? $permit['owner1'] : ucwords($permit['owner1'] . ' & ' . $permit['owner2']) ?>
                          </h1>
                          <hr class="w-50 mt-0 mb-0 mx-auto" style="border-top: 2px solid black;">
                          <h2 class="mt-0" style="font-size: 15px;">NAME OF BUSINESS OR ESTABLISHMENT</h2>
                        </div>
                        <h2 class="mt-3" style="text-indent: 40px; font-size: 15px;">This clearance is granted in accordance with section
                          152 of R.A. 7160 of Barangay Tax Ordinance, provided however, that the necessary fees are paid
                          to the Barangay Treasurer.</h2>
                        <h2 class="mt-3" style="text-indent: 40px; font-size: 15px;">This is non-transferable and shall be deemed null
                          and void upon failure by the owner to follow the said rules and regulations set forth by the
                          Local Government Unit of <span style="font-size:15px"><?= ucwords($town) ?>.</h2>
                        <h2 class="mt-3" style="font-size: 15px;">Issued on <span class="fw-bold"
                            style="font-size:15px"><?= date('m/d/Y') ?></span> at <span
                            style="font-size:15px"><?= ucwords($brgy . ', ' . $town) ?></span>.</h2>
                      </div><br><br>
                      <div class="col-md-10">
    <div class="p-3 text-right mt-2 mr-5">
        <h1 class="fw-bold text-uppercase" style="font-size: 15px; margin-bottom: 0;"><u><?= ucwords($captain['name']) ?></u></h1>
        <p class="mr-5" style="font-size: 13px; margin-top: 2px;">PUNONG BARANGAY</p>
    </div>
</div>
                      <div class="col-md-12 mb-4">
                        <h4 class="mb-0" style="font-size: 15px;"><i>CTC No.:_____________</i></h4>
                        <h4 class="mb-0" style="font-size: 15px;"><i>Issued On.:_____________</i></h4>
                        <h4 class="mb-0" style="font-size: 15px;"><i>Isuued at.:<u><?= ucwords($brgy . ',' . $town) ?></u></i></h4>
                        <h4 class="mb-0" style="font-size: 15px;"><i>OR No.:_____________</i></h4>
                      
                      </div>
                      <p><i>(This permit, while in force, shall be posted in a conspicious place in the
                          business premises.)</i></p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="modal fade" id="pment" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
          aria-hidden="true" data-backdrop="static" data-keyboard="false">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Create Payment</h5>
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
                    <input type="date" class="form-control" name="date" value="<?= date('Y-m-d') ?>">
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
                      name="details">Business Permit Payment</textarea>
                  </div>
              </div>
              <div class="modal-footer">
                <input type="hidden" name="resident_id" value="<?= $_GET['id'] ?>">
                <input type="hidden" name="request_id" value="<?= getBody('request_id', $_GET) ?>">
                <input type="hidden" name="create-payment" value="<?= $_GET['id'] ?>">
                <input type="hidden" name="certificate_id" value="5">
                <button type="button" class="btn btn-secondary" onclick="goBack()">Close</button>
                <button type="submit" class="btn btn-primary">Save</button>
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
