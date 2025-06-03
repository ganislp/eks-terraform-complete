resource "kubernetes_persistent_volume_claim_v1" "efs_pvc" {
  metadata {
    name = "efs-claim"
  }
  spec {
     access_modes = ["ReadWriteMany"]
    storage_class_name = kubernetes_storage_class_v1.efs_sc.metadata[0].name 
        resources {
      requests = {
        storage = "5Gi" 
      }
    }
  }
}