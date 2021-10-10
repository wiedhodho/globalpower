{extends file="master/index.tpl"}

{block name='css'}
{/block}

{block name='js'}
<script>
function editStatus(){
    $('#edit-status').modal('show');
}
</script>
{/block}

{block name='content'}
<div class="content-wrapper">
  <!-- Content Header (Page header) -->
  <div class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1 class="m-0 text-dark">{$halaman|end}</h1>
        </div><!-- /.col -->
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="{base_url()}">Home</a></li>
            {foreach from=$halaman item=a key=k}
            {if $a==$halaman|end}
            <li class="breadcrumb-item active">{$a}</li>
            {else}
            <li class="breadcrumb-item"><a href="{base_url()}{$k}">{$a}</a></li>
            {/if}
            {/foreach}
          </ol>
          <br />
        </div><!-- /.col -->
      </div><!-- /.row -->
    </div><!-- /.container-fluid -->
  </div>
  <!-- /.content-header -->

  <!-- Main content -->
  <section class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-6">
          <div class="card card-primary">
            <div class="card-header">
              <h3 class="card-title">Customer</h3>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i>
                </button>
              </div>
              <!-- /.card-tools -->
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <div class="row">
                <div class="col-md-4">Nama</div><div class="col-md-8"> {$trans->customer_nama} - {$trans->customer_site}</div>
              </div>
              <div class="row">
                <div class="col-md-4">Alamat</div><div class="col-md-8"> {$trans->customer_alamat}</div>
              </div>
              <div class="row">
                <div class="col-md-4">Telp</div><div class="col-md-8"> {$trans->customer_telp}</div>
              </div>
              <div class="row">
                <div class="col-md-4">Email</div><div class="col-md-8"> {$trans->customer_email}</div>
              </div>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
        <div class="col-md-6">
          <div class="card card-success">
            <div class="card-header">
              <h3 class="card-title">Quotation</h3>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i>
                </button>
              </div>
              <!-- /.card-tools -->
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <div class="row">
                <div class="col-md-4">Nomor</div><div class="col-md-8"> {$trans->quotation_nomor} &nbsp;&nbsp;&nbsp;<a href="{base_url()}quotation/download/{$trans->quotation_id}" class="btn btn-default btn-xs"><i class="fa fa-download"></i> Download</a></div>
              </div>
              <div class="row">
                <div class="col-md-4">Tanggal</div><div class="col-md-8"> {$trans->quotation_tanggal}</div>
              </div>
              <div class="row">
                <div class="col-md-4">Dibuat oleh</div><div class="col-md-8"> {$trans->quotation_user}</div>
              </div>
              <div class="row">
                <div class="col-md-4">Total</div><div class="col-md-8"> Rp {($trans->quotation_total + ($trans->quotation_total*$trans->quotation_pajak/100) - $trans->quotation_discount)|number_format}</div>
              </div>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
        <div class="col-md-6">
          <div class="card card-warning">
            <div class="card-header">
              <h3 class="card-title">SPB</h3>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i>
                </button>
              </div>
              <!-- /.card-tools -->
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <div class="row">
                <div class="col-md-4">Nomor</div><div class="col-md-8"> {$spb->spb_nomor} &nbsp;&nbsp;&nbsp;<a href="{base_url()}spb/download/{$spb->spb_id}" class="btn btn-default btn-xs"><i class="fa fa-download"></i> Download</a></div>
              </div>
              <div class="row">
                <div class="col-md-4">Tanggal</div><div class="col-md-8"> {$spb->spb_tanggal}</div>
              </div>
              <div class="row">
                <div class="col-md-4">Dibuat oleh</div><div class="col-md-8"> {$spb->spb_user}</div>
              </div>
              <div class="row">
                <div class="col-md-4">PO / REF</div><div class="col-md-8"> {$spb->spb_ref}</div>
              </div>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
        <div class="col-md-6">
          <div class="card card-danger">
            <div class="card-header">
              <h3 class="card-title">Invoice</h3>
              <div class="card-tools">
              <button type="button" class="btn btn-tool" onclick="editStatus()"><i class="fas fa-edit"></i>
                </button>
                <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i>
                </button>
              </div>
              <!-- /.card-tools -->
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <div class="row">
                <div class="col-md-4">Nomor</div>
                <div class="col-md-8">
                  {$inv->inv_nomor}
                  {if $inv->inv_nomor}
                    &nbsp;&nbsp;&nbsp;<a href="{base_url()}invoice/download/{$inv->inv_id}" class="btn btn-default btn-xs"><i class="fa fa-download"></i> Download</a>
                  {/if}
                </div>
              </div>
              <div class="row">
                <div class="col-md-4">Tanggal</div><div class="col-md-8"> {$inv->inv_tanggal}</div>
              </div>
              <div class="row">
                <div class="col-md-4">Dibuat oleh</div><div class="col-md-8"> {$inv->inv_user}</div>
              </div>
              <div class="row">
                <div class="col-md-4">Total</div>
                <div class="col-md-8">
                  Rp {($inv->inv_total + ($inv->inv_total*$inv->inv_pajak/100) - $inv->inv_discount)|number_format}&nbsp;&nbsp;&nbsp;
                  {if $inv->inv_status==1}
                    <small class="badge badge-success">Lunas</small>
                  {else}
                    <small class="badge badge-danger">Belum Dibayar</small>
                  {/if}
                </div>
              </div>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
      </div>
    </div><!--/. container-fluid -->
    <div class="modal fade" id="edit-status">
      <div class="modal-dialog">
        <div class="modal-content">
          <form class="form-horizontal" method="post" action="{base_url()}transaksi/update_status">
          <div class="modal-header">
            <h4 class="modal-title">Ubah Status</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              <div class="form-group row">
                <label for="inputEmail3" class="col-sm-4 col-form-label">Status</label>
                <div class="col-sm-8">
                <input type="hidden" name="id" value="{$trans->quotation_id}">
                  <select name="status" class="form-control" required="">
                    <option value="">Pilih Status</option>
                    {foreach from=$status item=a key=k}
                    <option value="{$k}">{$a}</option>
                    {/foreach}
                  </select>
                </div>
              </div>
          </div>
          <div class="modal-footer justify-content-between">
            <button type="button" class="btn btn-primary" data-dismiss="modal">Batal</button>
            <button type="submit" class="btn btn-danger">Simpan</button>
          </div>
          </form>
        </div>
        <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
    </div>
  </section>
  <!-- /.content -->
</div>
{/block}
