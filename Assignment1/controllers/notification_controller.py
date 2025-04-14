from flask import Blueprint, jsonify

notification_bp = Blueprint('notification', __name__, url_prefix='/notifications')

@notification_bp.route('/test', methods=['GET'])
def test_notification():
    return jsonify({"message": "Notifications module is working"})